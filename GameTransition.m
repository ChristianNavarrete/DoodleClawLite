//
//  GameTransition.m
//  DoodleClaw
//
//  Created by HoodsDream on 3/4/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameTransition.h"
#import "StartMenu.h"




@implementation GameTransition {
    
}


+(id) scene
{
    
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameTransition node];
    [scene addChild:layer];
    return scene;
}


-(id) init
{
    if( (self=[super init]))
    {
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        
        self.isTouchEnabled = YES;
        
        
        circle = [CCSprite spriteWithFile:@"newTransitionCircleGreen.png"];
        circle.position = CGPointMake(screenSize.width / 2, screenSize.height/2 - 10);
        circle.anchorPoint = ccp(0.5, 0.5); //This would be the center of the image for a 30 X 30 image.
        [circle setOpacity:0];
        //[circle runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1.0 angle:10]]];
        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:1.5];
        CCMoveTo *moveUp = [CCMoveTo actionWithDuration:1.0 position:CGPointMake(screenSize.width / 2, screenSize.height/2)];
        [circle runAction:fadeIn];
        [circle runAction:moveUp];
        [self addChild:circle z:1];
        
        presshold = [CCSprite spriteWithFile:@"presshold-02.png"];
        presshold.position = CGPointMake(screenSize.width / 2, screenSize.height/2 + 120);
        presshold.anchorPoint = ccp(0.5, 0.5); //This would be the center of the image for a 30 X 30 image.
        [self addChild:presshold z:1];
        
        caution = [CCSprite spriteWithFile:@"stayAway02.png"];
        caution.position = CGPointMake(screenSize.width / 2 - 3, screenSize.height/2 + 95);
        caution.anchorPoint = ccp(0.5, 0.5); //This would be the center of the image for a 30 X 30 image.
        [self addChild:caution z:1];
        
        
        background = [CCSprite spriteWithFile:@"png.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background z:0];
        
        
        CCMenuItem *startMenuItem = [CCMenuItemImage
                                     itemWithNormalImage:@"goBack.png" selectedImage:@"goBackPressed.png"
                                     target:self selector:@selector(backButton)];
        
        CCMenuItem *startMenuItem2 = [CCMenuItemImage
                                     itemWithNormalImage:@"greenCircleUnlocked.png" selectedImage:@"greenCircleUnlocked.png"
                                     target:self selector:@selector(greenCircle)];
        
        CCMenuItem *startMenuItem3 = [CCMenuItemImage
                                      itemWithNormalImage:@"blueCircleUnlocked.png" selectedImage:@"blueCircleUnlocked.png"
                                      target:self selector:@selector(greenCircle)];
        
        CCMenuItem *startMenuItem4 = [CCMenuItemImage
                                      itemWithNormalImage:@"pinkCircleUnlocked.png" selectedImage:@"pinkCircleUnlocked.png"
                                      target:self selector:@selector(greenCircle)];
        
        CCMenuItem *startMenuItem5 = [CCMenuItemImage
                                      itemWithNormalImage:@"purpleCircleUnlocked.png" selectedImage:@"purpleCircleUnlocked.png"
                                      target:self selector:@selector(greenCircle)];
        
        CCMenuItem *startMenuItem6 = [CCMenuItemImage
                                      itemWithNormalImage:@"orangeCircleUnlocked.png" selectedImage:@"orangeCircleUnlocked.png"
                                      target:self selector:@selector(greenCircle)];
        
        CCMenuItem *ex1 = [CCMenuItemImage
                           itemWithNormalImage:@"ex.png" selectedImage:@"ex.png" target:self selector:@selector(greenCircle)];
        
        CCMenuItem *ex2 = [CCMenuItemImage
                           itemWithNormalImage:@"ex.png" selectedImage:@"ex.png" target:self selector:@selector(greenCircle)];
        
        CCMenuItem *ex3 = [CCMenuItemImage
                           itemWithNormalImage:@"ex.png" selectedImage:@"ex.png" target:self selector:@selector(greenCircle)];
        
        CCMenuItem *ex4 = [CCMenuItemImage
                           itemWithNormalImage:@"ex.png" selectedImage:@"ex.png" target:self selector:@selector(greenCircle)];
        
        CCMenuItem *check = [CCMenuItemImage
                           itemWithNormalImage:@"check.png" selectedImage:@"check.png" target:self selector:@selector(greenCircle)];
        
        
        startMenuItem.position = ccp(screenSize.width/2 - 115,screenSize.height-25);
        startMenuItem2.position = ccp(40, 100);
        startMenuItem3.position = ccp(100, 100);
        startMenuItem4.position = ccp(160, 100);
        startMenuItem5.position = ccp(220, 100);
        startMenuItem6.position = ccp(280, 100);
        
        check.position = ccp(55, 135);
        
        ex1.position = ccp(115, 135);
        ex2.position = ccp(175, 135);
        ex3.position = ccp(235, 135);
        ex4.position = ccp(295, 135);
        
        CCMenu *startMenu = [CCMenu menuWithItems:startMenuItem,startMenuItem2,startMenuItem3,startMenuItem4,startMenuItem5,startMenuItem6,ex1,ex2,ex3,ex4,check,nil];
        startMenu.position = CGPointZero;
        [self addChild:startMenu];
      
        }
    
    return self;
}


-(void) greenCircle {
    nil;
}

-(void)backButton {
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInL transitionWithDuration:0.5 scene:[StartMenu scene]]];
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    
    if (CGRectContainsPoint([circle boundingBox], location)) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[GameLayer scene]]];
        
    }
    
}



-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
}




@end