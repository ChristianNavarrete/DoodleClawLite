//
//  GameTransition.h
//  DoodleClaw
//
//  Created by HoodsDream on 3/4/14.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <iAd/iAd.h>


@interface GameTransition : CCLayer {
    
    CCSprite *background;
    CCSprite *claw;
    CCSprite *circle;
    CCSprite *presshold;
    CCSprite *caution;
    

    
}

+(id)scene;


@end