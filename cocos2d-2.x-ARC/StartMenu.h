//
//  StartMenu.h
//  DoodleClaw
//
//  Created by HoodsDream on 11/14/13.
//  Copyright 2013 AsteroidBlues All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <Twitter/Twitter.h>



@interface StartMenu : CCLayer {
    
    CCSprite *menuBackground;
    CCSprite *splashScreen;
    CCSprite *leftClaw;
    CCSprite *rightClaw;
    CCSprite *rightClaw2;
    CCSprite *leftClaw2;
    CCSprite *highscoreLabel;
    
    CCNode<CCLabelProtocol>* highScoreLabel;
    
    NSString *postText;
  
}

 @property (nonatomic, strong)UIView *iAdView;

+(id)scene;


@end
