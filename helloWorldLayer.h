//
//  helloWorldLayer.h
//  DoodleClaw
//
//  Created by HoodsDream on 2/13/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <CCTargetedTouchDelegate>
{
    NSMutableArray *path;
    CCSprite *followSprite;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)follow;

-(void)clear;
-(void)movefollowSprite:(id)data;

@end