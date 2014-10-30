//
//  StartMenu.m
//  DoodleClaw
//
//  Created by HoodsDream on 11/14/13.
//  Copyright 2013 AteroidBlues. All rights reserved.
//

#import "StartMenu.h"
#import "GameLayer.h"
#import <CoreGraphics/CoreGraphics.h>
#import "cocos2d.h"
#import "CCNode+SFGestureRecognizers.h"
#import "GameTransition.h"
#import <Social/Social.h>
#import "purchaseLayer.h"





@implementation StartMenu {
        SystemSoundID soundEffect;
}



+(id) scene
{
        CCScene *scene = [CCScene node];
        CCLayer *layer = [StartMenu node];
        [scene addChild:layer];
        return scene;
        
}


-(id) init
{
    if( (self=[super init]))
    {
        
        [self scheduleUpdate];

        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"wood" ofType:@"aiff"];
        
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        
        AudioServicesCreateSystemSoundID(CFBridgingRetain(soundUrl), &soundEffect);
        
        
        _iAdView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        _iAdView.center=CGPointMake(screenSize.width/2, screenSize.height-_iAdView.frame.size.height+25);
        [_iAdView setBackgroundColor:[UIColor lightGrayColor]];
        [[[CCDirector sharedDirector]view]addSubview:_iAdView];

        
        
        highScoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapFont2.fnt"];
		highScoreLabel.position = CGPointMake(screenSize.width / 2 + 30, 115 );
		highScoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
        
        NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];

        NSInteger intValue = [fetchDefaults integerForKey:@"highscore"];
        
        [highScoreLabel setString:[NSString stringWithFormat:@"%li", (long)intValue]];
        
        postText = [NSString stringWithFormat:@"My Clash of Claws highscore is %li. Try to beat it! Developed by @AsteroidBlues_", (long)intValue];
        
        [self addChild:highScoreLabel z:1];

        
        self.isTouchEnabled = YES;
    
        
        menuBackground = [CCSprite spriteWithFile:@"clashStartBG03-01.png"];
        menuBackground.anchorPoint = ccp(0,0);
        [self addChild:menuBackground z:0];
        menuBackground.position = ccp(0,0);
        
        highScoreLabel = [CCSprite spriteWithFile:@"highscore.png"];
        highScoreLabel.anchorPoint = ccp(0,0);
        highScoreLabel.position = CGPointMake(screenSize.width / 2 - 38, 99 );
        [self addChild:highScoreLabel z:2];
        
    
        rightClaw = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw.position = CGPointMake(390,155);
        [self addChild:rightClaw z:2 tag:13];
        
        leftClaw = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw.position = CGPointMake(-70,155);
        [self addChild:leftClaw z:2 tag:7];
        
        rightClaw2 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw2.position = CGPointMake(390,218);
        [self addChild:rightClaw2 z:2 tag:14];
        
        
        leftClaw2 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw2.position = CGPointMake(-70,218);
        [self addChild:leftClaw2 z:2 tag:6];

        
        
        CCMoveTo *moveUp = [CCMoveTo actionWithDuration:0.8 position:ccp(splashScreen.position.x,screenSize.height)];
        
        
        CGPoint startPositionLeft1 = leftClaw.position;
        CCMoveTo *moveLeft1 = [CCMoveTo actionWithDuration:0.3 position:ccp(80,leftClaw.position.y)];
        CCMoveTo *moveBack1 = [CCMoveTo actionWithDuration:0.2 position:startPositionLeft1];
        CCDelayTime *delay1 = [CCDelayTime actionWithDuration:1.5];
        CCSequence *seq1 = [CCSequence actions: delay1,moveLeft1, moveBack1, nil];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:seq1];
        
        
        CGPoint startPositionRight2 = rightClaw.position;
        CCMoveTo *moveLeft2 = [CCMoveTo actionWithDuration:0.3 position:ccp(250,rightClaw.position.y)];
        CCMoveTo *moveBack2 = [CCMoveTo actionWithDuration:0.2 position:startPositionRight2];
        CCSequence *seq2 = [CCSequence actions: delay1, moveLeft2, moveBack2, nil];
        CCRepeatForever *repeat2 = [CCRepeatForever actionWithAction:seq2];
        
        CGPoint startPositionRight3 = rightClaw2.position;
        CCMoveTo *moveLeft3 = [CCMoveTo actionWithDuration:0.3 position:ccp(250,rightClaw2.position.y)];
        CCMoveTo *moveBack3 = [CCMoveTo actionWithDuration:0.2 position:startPositionRight3];
        CCDelayTime *delay3 = [CCDelayTime actionWithDuration:1.2];
        CCSequence *seq3 = [CCSequence actions: delay3, moveLeft3, moveBack3, nil];
        CCRepeatForever *repeat3 = [CCRepeatForever actionWithAction:seq3];
        
        CGPoint startPositionLeft4 = leftClaw2.position;
        CCMoveTo *moveLeft4 = [CCMoveTo actionWithDuration:0.3 position:ccp(80,leftClaw2.position.y)];
        CCMoveTo *moveBack4 = [CCMoveTo actionWithDuration:0.2 position:startPositionLeft4];
        CCDelayTime *delay4 = [CCDelayTime actionWithDuration:1.2];
        CCSequence *seq4 = [CCSequence actions: delay4,moveLeft4, moveBack4, nil];
        CCRepeatForever *repeat4 = [CCRepeatForever actionWithAction:seq4];

      
        
        [rightClaw2 runAction:repeat3];
        [leftClaw2 runAction:repeat4];

        
        [rightClaw runAction:repeat2];
        [leftClaw runAction:repeat];
 
        
        [splashScreen runAction:moveUp];

        
        CCMenuItem *startMenuItem = [CCMenuItemImage
                                    itemWithNormalImage:@"playButtonFlat.png" selectedImage:@"playButtonFlatPressed.png"
                                    target:self selector:@selector(startGame:)];
        
        CCMenuItem *startMenuItem2 = [CCMenuItemImage
                                    itemWithNormalImage:@"shopButtonFlat.png" selectedImage:@"shopButtonFlatPressed.png"
                                      target:self selector:@selector(storeTransition:)];
        
        CCMenuItem *startMenuItem3 = [CCMenuItemImage
                                      itemWithNormalImage:@"twitter2.png" selectedImage:@"twitter2.png"
                                      target:self selector:@selector(twitter:)];
        
        CCMenuItem *startMenuItem4 = [CCMenuItemImage
                                      itemWithNormalImage:@"facebook2.png" selectedImage:@"facebook2.png"
                                      target:self selector:@selector(facebook:)];
        
        startMenuItem.position = ccp(screenSize.width/2,155);
        startMenuItem2.position = ccp(screenSize.width/2,218);
        startMenuItem3.position = ccp(120,70);
        startMenuItem4.position = ccp(195,70);
        CCMenu *startMenu = [CCMenu menuWithItems:startMenuItem, startMenuItem2,startMenuItem3, startMenuItem4, nil];
        startMenu.position = CGPointZero;
        [self addChild:startMenu];

  
    }
    
    return self;
}




- (void) bannerViewDidLoadAd:(ADBannerView *)banner {
    
    
    
    
}


- (void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    
    
    return YES;
}







-(void) playSmash {
    
    AudioServicesPlaySystemSound(soundEffect);
    
}


- (void) startGame: (id) sender
{

    [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];

    [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInR transitionWithDuration:0.5 scene:[GameTransition scene]]];
    

}

- (void) storeTransition: (id) sender
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
    
    NSURL *iTunesLink= [NSURL URLWithString:@"https://itunes.apple.com/us/app/clashofclaws/id910701516?ls=1&mt=8"];
    
    [[UIApplication sharedApplication] openURL:iTunesLink];
}



- (void) twitter:(id) sender
{

    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];

    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitter = [[SLComposeViewController alloc] init];
        twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:[NSString stringWithFormat:@"%@,",postText]];
        [twitter addImage:[UIImage imageNamed:@"socialImg2.png"]];
        [[CCDirector sharedDirector] presentViewController:twitter animated:YES completion:nil];
        [twitter setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Posted";
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setInteger:1 forKey:@"Shared"];
                    [ud synchronize];
                    break;
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }];
    } else {
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Uh-oh!" message:@"Make sure you're signed into Twitter on your device." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alertError show];
    }
    
    
    
}





-(void) checkForCollision {
    CGRect leftClawRect = CGRectMake(leftClaw.position.x -     (leftClaw.contentSize.width /1.6) ,
                                     leftClaw.position.y -     (leftClaw.contentSize.height /1.2),
                                     leftClaw.contentSize.width,
                                     leftClaw.contentSize.height);
    
    CGRect leftClawRect2 = CGRectMake(leftClaw2.position.x -     (leftClaw2.contentSize.width /1.6) ,
                                      leftClaw2.position.y -     (leftClaw2.contentSize.height /1.2),
                                      leftClaw2.contentSize.width,
                                      leftClaw2.contentSize.height);
    
    CGRect rightClawRect = CGRectMake(rightClaw.position.x -     (rightClaw.contentSize.width /2.5) ,
                                      rightClaw.position.y -     (rightClaw.contentSize.height /1.2),
                                      rightClaw.contentSize.width,
                                      rightClaw.contentSize.height);
    
    CGRect rightClawRect2 = CGRectMake(rightClaw2.position.x -     (rightClaw2.contentSize.width /2.5) ,
                                       rightClaw2.position.y -     (rightClaw2.contentSize.height /1.2),
                                       rightClaw2.contentSize.width,
                                       rightClaw2.contentSize.height);
    
    if (CGRectIntersectsRect(leftClawRect, rightClawRect)) {
        [self playSmash];
    }
    
    if (CGRectIntersectsRect(leftClawRect2, rightClawRect2)) {
        [self playSmash];
    }
    
    
}










- (void) facebook:(id) sender
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];

    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebook = [[SLComposeViewController alloc] init];
        facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebook setInitialText:[NSString stringWithFormat:@"%@",postText]];
        [facebook addImage:[UIImage imageNamed:@"socialImg2.png"]];
        [facebook addURL: [NSURL URLWithString:
                                    @"http://itunes.com/apps/PixelClash"]];
        [[CCDirector sharedDirector] presentViewController:facebook animated:YES completion:nil];
        [facebook setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Posted";
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setInteger:1 forKey:@"Shared"];
                    [ud synchronize];
                    break;
            }   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
        }];
    } else {        
            UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Uh-oh!" message:@"Make sure you're signed into Facebook on your device." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alertError show];
        }
 
}

-(void)update:(ccTime)delta {
    [self checkForCollision];
}


-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

}





@end
