//
//  GameLayer.h
//  DoodleClaw
//
//  Created by HoodsDream on 10/18/13.
//  Copyright 2013 AsteroidBlues All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"



@interface GameLayer  : CCLayer {
    
    CCSprite *player;
    CCSprite *background;
    
    CCSprite *leftClaw0;
    CCSprite *leftClaw1;
    CCSprite *leftClaw2;
    CCSprite *leftClaw3;
    CCSprite *leftClaw4;
    CCSprite *leftClaw5;
    CCSprite *leftClaw6;
    CCSprite *leftClaw7;
    
    CCSprite *rightClaw0;
    CCSprite *rightClaw1;
    CCSprite *rightClaw2;
    CCSprite *rightClaw3;
    CCSprite *rightClaw4;
    CCSprite *rightClaw5;
    CCSprite *rightClaw6;
    CCSprite *rightClaw7;
     
        int score;
    
    CCNode<CCLabelProtocol>* scoreLabel;
    CCSprite *highscoreBG;
    
} 

@property (nonatomic,assign) BOOL isEnabled;
@property (nonatomic,assign) BOOL isBroken;
@property (nonatomic,assign) BOOL beatHighscore;
@property (nonatomic,assign) BOOL adsRemoved;




+(id) scene;

@end
