

// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

// on "init" you need to initialize your instance

-(void)draw{
    
    glColor4ub(255, 255, 0, 255);
    glLineWidth(5.0);
    
    if ([path count]>2) {
        for(int i = 0;i<[path count]-1;i++){
            CGPoint originPoint = [[path objectAtIndex:i] CGPointValue];
            CGPoint destinatonPoint = [[path objectAtIndex:i+1] CGPointValue];
            ccDrawLine(originPoint, destinatonPoint);
            
        }
        
    }
}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super's" return value
    if( (self=[super init]) ) {
        
        self.isTouchEnabled = YES;
        path = [NSMutableArray new];
        followSprite = [CCSprite spriteWithFile:@"Icon-Small.png"] ;
        followSprite.parent = nil;
        
        CCMenuItemFont *itemFollow = [CCMenuItemFont itemFromString:@"Follow" target:self selector:@selector(follow)];
        CCMenuItemFont *itemClear = [CCMenuItemFont itemFromString:@"Clear" target:self selector:@selector(clear)];
        
        CCMenu *menu = [CCMenu menuWithItems:itemFollow,itemClear,nil];
        
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp(240,30)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
    }
    return self;
}

-(void)follow{
    
    [followSprite stopAllActions];
    if ([path count] > 0) {
        followSprite.position = [[path objectAtIndex:0] CGPointValue];
        if ([followSprite parent] == nil) {
            [self addChild:followSprite];
            
        }
    }
    if ([path count] >=2) {
        
        NSNumber *newPosition = [NSNumber numberWithInt:1] ;
        CCMoveTo *move = [CCMoveTo actionWithDuration:.1 position:path objectAtIndex:1]; CGPointValue;
        CCCallFuncO *callFunc = [CCCallFuncO actionWithTarget:self selector:@selector(movefollowSprite:) object:newPosition];
        [followSprite runAction:[CCSequence actionOne:move two:callFunc]];
        
    }
    
}

-(void)movefollowSprite:(void *)data{
    NSNumber *moveToPosition = (NSNumber*)data;
    if ([moveToPosition intValue] >= [path count]) {
        [moveToPosition release];
        return;
    }
    
    [path removeObjectAtIndex:0];
    NSNumber *newPosition = [[NSNumber numberWithInt:1] retain];
    CCMoveTo *move = [CCMoveTo actionWithDuration:.1 position:path objectAtIndex:[moveToPosition intValue CGPointValue]];
    CCCallFuncO *callFunc = [CCCallFuncO actionWithTarget:self selector:@selector(movefollowSprite:) object:newPosition];
    [followSprite runAction:[CCSequence actionOne:move two:callFunc]];
    [moveToPosition release];
}

-(void)clear{
    if ([followSprite parent] != nil) {
        [self removeChild:followSprite cleanup:YES];
        followSprite.parent = nil;
    }
    [path removeAllObjects];
}

-(void)registerWithTouchDispatcher{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:10 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint p = [self convertTouchToNodeSpace:touch];
    [path addObject:[NSValue valueWithCGPoint:p]];
    return YES;
    
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint p = [self convertTouchToNodeSpace:touch];
    [path addObject:[NSValue valueWithCGPoint:p]];
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    
}

- (void) dealloc
{
    
    [followSprite release];
    [path release];
    [super dealloc];
}



@end
