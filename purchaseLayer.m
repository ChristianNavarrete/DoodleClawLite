//
//  purchaseLayer.m
//  DoodleClaw
//
//  Created by HoodsDream on 2/19/14.
//  Copyright 2014 AsteroidBlues All rights reserved.
//

#import "purchaseLayer.h"
#import "SimpleAudioEngine.h"
#import "StartMenu.h"
#import <iAd/iAd.h>
#import "GameLayer.h"
#import <StoreKit/StoreKit.h>


@implementation purchaseLayer {
    
}


+(id) scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [purchaseLayer node];
    [scene addChild:layer];
    return scene;
}


-(id) init
{
    if( (self=[super init]))
    {
        
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        
        background = [CCSprite spriteWithFile:@"png.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background z:0];
         
        
        CCMenuItem *startMenuItem = [CCMenuItemImage
                                     itemWithNormalImage:@"removeAds.png" selectedImage:@"removeAdsPressed.png"
                                     target:self selector:@selector(backButton)];
        
        CCMenuItem *startMenuItem2 = [CCMenuItemImage
                                      itemWithNormalImage:@"unlockCircles.png" selectedImage:@"unlockCirclesPressed.png"
                                      target:self selector:@selector(backButton)];
        
        CCMenuItem *startMenuItem3 = [CCMenuItemImage
                                      itemWithNormalImage:@"restorePurchases.png" selectedImage:@"restorePurchasesPressed.png"
                                      target:self selector:@selector(backButton)];
        
        CCMenuItem *startMenuItem4 = [CCMenuItemImage
                                      itemWithNormalImage:@"goBack.png" selectedImage:@"goBackPressed.png"
                                      target:self selector:@selector(backButton)];
        
        
        startMenuItem.position = ccp(screenSize.width/2,280);
        startMenuItem2.position = ccp(screenSize.width/2,325);
        startMenuItem3.position = ccp(screenSize.width/2, screenSize.height/2 - 50);
        startMenuItem4.position = ccp(screenSize.width/2 - 115,screenSize.height-25);
        
        CCMenu *storeMenu = [CCMenu menuWithItems:startMenuItem, startMenuItem2,startMenuItem3, startMenuItem4, nil];
        storeMenu.position = CGPointZero;
        [self addChild:storeMenu];
        
    }
    
    return self;
}

         

-(void)backButton {
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInL transitionWithDuration:0.5 scene:[StartMenu scene]]];
}



@end
