//
//  GameLayer.m
//  DoodleClaw
//
//  Created by HoodsDream on 10/18/13.
//  Copyright 2013 AsteroidBlues All rights reserved.
//

#import "cocos2d.h"
#import "GameLayer.h"
#import "SIAlertView.h"
#import "StartMenu.h"
#import "GameTransition.h"
#import <AudioToolbox/AudioToolbox.h>



@interface GameLayer() 

@end



@implementation GameLayer {
    SystemSoundID soundEffect;
    SystemSoundID highscoreSoundEffect;
}


+(id) scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameLayer node];
    [scene addChild:layer];
    return scene;
    
}



-(id) init
{
    if( (self=[super init]))
        
    {
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"wood" ofType:@"aiff"];
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        AudioServicesCreateSystemSoundID(CFBridgingRetain(soundUrl), &soundEffect);
        
        NSString *soundPath2 = [[NSBundle mainBundle] pathForResource:@"highscoreSound" ofType:@"wav"];
        NSURL *soundUrl2 = [NSURL fileURLWithPath:soundPath2];
        AudioServicesCreateSystemSoundID(CFBridgingRetain(soundUrl2), &highscoreSoundEffect);
    
        
            
        
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
        self.isTouchEnabled = YES;
        
        _isEnabled = NO;
        _isBroken = NO;
        _beatHighscore = NO;
        
        player = [CCSprite spriteWithFile:@"greenCircle.png"];
        [self addChild:player z:2 ];
        player.position = CGPointMake(screenSize.width / 2, screenSize.height/2);
        
        
        background = [CCSprite spriteWithFile:@"png.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background z:0];
        
        
        scoreLabel = [CCLabelBMFont labelWithString:@"0" fntFile:@"bitmapFont2.fnt"];
		scoreLabel.position = CGPointMake(screenSize.width / 2, screenSize.height);
		// Adjust the label's anchorPoint's y position to make it align with the top.
		scoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
        
        
		// Add the score label with z value of -1 so it's drawn below everything else
		[self addChild:scoreLabel z:5];
        [self scheduleUpdate];

        [self schedule: @selector(clawAttack:) interval:.7];
        
        
        //add all the claws!
  
        leftClaw0 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw0.position = CGPointMake(-70,507);
        [self addChild:leftClaw0 z:2 ];
        
        leftClaw1 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw1.position = CGPointMake(-70,447);
        [self addChild:leftClaw1 z:2 ];
        
        
        leftClaw2 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw2.position = CGPointMake(-70,377);
        [self addChild:leftClaw2 z:2 tag:2];
        
        
        leftClaw3 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw3.position = CGPointMake(-70,310);
        [self addChild:leftClaw3 z:2 tag:3];
        
        
        leftClaw4 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw4.position = CGPointMake(-70,240);
        [self addChild:leftClaw4 z:2 tag:4];
        
        
        leftClaw5 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw5.position = CGPointMake(-70,170);
        [self addChild:leftClaw5 z:2 tag:5];
        
         leftClaw6 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw6.position = CGPointMake(-70,100);
        [self addChild:leftClaw6 z:2 tag:6];
        
        leftClaw7 = [CCSprite spriteWithFile:@"flatClawLeft2.png"];
        leftClaw7.position = CGPointMake(-70,30);
        [self addChild:leftClaw7 z:2 tag:7];
        
      
        
        
        rightClaw0 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw0.position = CGPointMake(390,507);
        [self addChild:rightClaw0 z:2 tag:8];

        rightClaw1 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw1.position = CGPointMake(390,450);
        [self addChild:rightClaw1 z:2 tag:8];
        
        rightClaw2 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw2.position = CGPointMake(390,377);
        [self addChild:rightClaw2 z:2 tag:9];
        
        rightClaw3 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw3.position = CGPointMake(390,310);
        [self addChild:rightClaw3 z:2 tag:10];
        
        
        rightClaw4 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw4.position = CGPointMake(390,240);
        [self addChild:rightClaw4 z:2 tag:11];
        
        
        rightClaw5 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw5.position = CGPointMake(390,170);
        [self addChild:rightClaw5 z:2 tag:12];
        
        rightClaw6 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw6.position = CGPointMake(390,100);
        [self addChild:rightClaw6 z:2 tag:13];
        
        rightClaw7 = [CCSprite spriteWithFile:@"flatClawRight2.png"];
        rightClaw7.position = CGPointMake(390,30);
        [self addChild:rightClaw7 z:2 tag:14];
         
        [self initSoundEffects];
    }
    
    return self;
}




//- (void) bannerViewDidLoadAd:(ADBannerView *)banner {
//
//    
//}
//
//
//- (void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
//    
//}
//
//
//-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
//    
//    return YES;
//}





-(void) initSoundEffects {
    
    [[SimpleAudioEngine sharedEngine] soundSourceForFile:@"wood.aiff"];
    
}


-(void) playSmash {
    
    AudioServicesPlaySystemSound(soundEffect);
    
}

-(void)clawAttack:(ccTime) dt{
    
    NSArray *leftClaws = [NSArray arrayWithObjects: leftClaw0, leftClaw1, leftClaw2, leftClaw3, leftClaw4, leftClaw5, leftClaw6,  leftClaw7, nil];
        
    int r = arc4random() % [leftClaws count];
    
    CCSprite *randomClaw = (CCSprite *)[leftClaws objectAtIndex:r];
    
    CGPoint startPositionRight = randomClaw.position;
    CCMoveTo *moveRight = [CCMoveTo actionWithDuration:0.5 position:ccp(70,randomClaw.position.y)];
    CCMoveTo *moveBack = [CCMoveTo actionWithDuration:0.1 position:startPositionRight];
    CCSequence *rightSeq = [CCSequence actions: moveRight, moveBack, nil];
    
    CGPoint startPositionLeft0 = rightClaw0.position;
    CCMoveTo *moveLeft0 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw0.position.y)];
    CCMoveTo *moveBack0 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft0];
    CCSequence *seq0 = [CCSequence actions: moveLeft0, moveBack0, nil];
    
    CGPoint startPositionLeft1 = rightClaw1.position;
    CCMoveTo *moveLeft1 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw1.position.y)];
    CCMoveTo *moveBack1 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft1];
    CCSequence *seq1 = [CCSequence actions: moveLeft1, moveBack1, nil];
    
    
    CGPoint startPositionLeft2 = rightClaw2.position;
    CCMoveTo *moveLeft2 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw2.position.y)];
    CCMoveTo *moveBack2 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft2];
    CCSequence *seq2 = [CCSequence actions: moveLeft2, moveBack2, nil];
    
    
    CGPoint startPositionLeft3 = rightClaw3.position;
    CCMoveTo *moveLeft3 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw3.position.y)];
    CCMoveTo *moveBack3 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft3];
    CCSequence *seq3 = [CCSequence actions: moveLeft3, moveBack3, nil];
    
    CGPoint startPositionLeft4 = rightClaw4.position;
    CCMoveTo *moveLeft4 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw4.position.y)];
    CCMoveTo *moveBack4 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft4];
    CCSequence *seq4 = [CCSequence actions: moveLeft4, moveBack4, nil];
    
    CGPoint startPositionLeft5 = rightClaw5.position;
    CCMoveTo *moveLeft5 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw5.position.y)];
    CCMoveTo *moveBack5 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft5];
    CCSequence *seq5 = [CCSequence actions: moveLeft5, moveBack5, nil];
    
    CGPoint startPositionLeft6 = rightClaw6.position;
    CCMoveTo *moveLeft6 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw6.position.y)];
    CCMoveTo *moveBack6 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft6];
    CCSequence *seq6 = [CCSequence actions: moveLeft6, moveBack6, nil];
    
    CGPoint startPositionLeft7 = rightClaw7.position;
    CCMoveTo *moveLeft7 = [CCMoveTo actionWithDuration:0.5 position:ccp(240,rightClaw7.position.y)];
    CCMoveTo *moveBack7 = [CCMoveTo actionWithDuration:0.1 position:startPositionLeft7];
    CCSequence *seq7 = [CCSequence actions: moveLeft7, moveBack7, nil];
    
    
    if (randomClaw == leftClaw1) {
        [rightClaw1 runAction:seq1];
    }
    else if (randomClaw == leftClaw0) {
        [rightClaw0 runAction:seq0];
    }
    else if (randomClaw == leftClaw2) {
        [rightClaw2 runAction:seq2];
    }
    else if (randomClaw == leftClaw2) {
        [rightClaw2 runAction:seq2];
    }
    else if (randomClaw == leftClaw3) {
        [rightClaw3 runAction:seq3];
    }
    else if (randomClaw == leftClaw4) {
        [rightClaw4 runAction:seq4];
    }
    else if (randomClaw == leftClaw5) {
        [rightClaw5 runAction:seq5];
    }
    else if (randomClaw == leftClaw6) {
        [rightClaw6 runAction:seq6];
    }
    else if (randomClaw == leftClaw7) {
        [rightClaw7 runAction:seq7];
    }

    [randomClaw runAction:rightSeq];
 
}



-(void) showAlert {


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    if (score > [fetchDefaults integerForKey:@"highscore"]) {
        [defaults setInteger:score forKey:@"highscore"];
    }

    
    if (_isEnabled == NO) {
        
        NSString *scoreString = [NSString stringWithFormat:@"Score: %i \n Wanna play again?", score];
        
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Ouch!" andMessage:scoreString];
        [alertView addButtonWithTitle:@"No, that hurt."
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                                  [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];

                                  [[CCDirector sharedDirector] resume];
                                  [[CCDirector sharedDirector] startAnimation];
                                  [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInL transitionWithDuration:0.5 scene:[StartMenu scene]]];
                                  
                                  

                              }];
        [alertView addButtonWithTitle:@"Fershizzle!"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
                                  [[CCDirector sharedDirector] resume];
                                  [[CCDirector sharedDirector] startAnimation];
                                  [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInT transitionWithDuration:0.5 scene:[GameTransition scene]]];
                              }];


        alertView.buttonFont = [UIFont boldSystemFontOfSize:16];
        alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
        [alertView show];
        
        _isEnabled = YES;
        _isBroken = YES;
    }

    if (_isEnabled == YES) {
        return;
    }
    
   
    
}





-(void) showAlert2 {
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    if (score > [fetchDefaults integerForKey:@"highscore"]) {
        [defaults setInteger:score forKey:@"highscore"];
    }
    
    
    if (_isEnabled == NO) {
        
        NSString *scoreString = [NSString stringWithFormat:@"Score: %i \n Wanna play again?", score];
        
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Where'd you go?" andMessage:scoreString];
        [alertView addButtonWithTitle:@"Outta here."
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                                  [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
                                  
                                  [[CCDirector sharedDirector] resume];
                                  [[CCDirector sharedDirector] startAnimation];
                                  [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInL transitionWithDuration:0.5 scene:[StartMenu scene]]];
                                  
                                  
                                  
                              }];
        [alertView addButtonWithTitle:@"Let's do this!"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  [[SimpleAudioEngine sharedEngine] playEffect:@"button.wav"];
                                  [[CCDirector sharedDirector] resume];
                                  [[CCDirector sharedDirector] startAnimation];
                                  [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInT transitionWithDuration:0.5 scene:[GameTransition scene]]];
                              }];
        
        
        alertView.buttonFont = [UIFont boldSystemFontOfSize:16];
        alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
        [alertView show];
        
        _isEnabled = YES;
        _isBroken = YES;
    }
    
    if (_isEnabled == YES) {
        return;
    }
    
    
    
}





-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    [player setPosition:location];
    
}


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self removeChild:scoreLabel cleanup: YES];
    [self removeChild:player cleanup: YES];
    [[CCDirector sharedDirector] pause];
    [self showAlert2];
    
}



-(void)checkForCollisions{
    
    CGRect playerRect = CGRectMake(player.position.x -     (player.contentSize.width/2),
                                   player.position.y -     (player.contentSize.height/1.5),
                                   player.contentSize.width,
                                   player.contentSize.height);
    
    CGRect leftClawRect0 = CGRectMake(leftClaw0.position.x -     (leftClaw0.contentSize.width/1.6),
                                   leftClaw0.position.y -     (leftClaw0.contentSize.height/1.2),
                                   leftClaw0.contentSize.width,
                                   leftClaw0.contentSize.height);
    
    CGRect leftClawRect1 = CGRectMake(leftClaw1.position.x -     (leftClaw1.contentSize.width /1.6) ,
                                     leftClaw1.position.y -     (leftClaw1.contentSize.height /1.2),
                                     leftClaw1.contentSize.width,
                                     leftClaw1.contentSize.height);
    
    CGRect leftClawRect2 = CGRectMake(leftClaw2.position.x -     (leftClaw2.contentSize.width /1.6) ,
                                      leftClaw2.position.y -     (leftClaw2.contentSize.height /1.2),
                                      leftClaw2.contentSize.width,
                                      leftClaw2.contentSize.height);
    
    CGRect leftClawRect3 = CGRectMake(leftClaw3.position.x -     (leftClaw3.contentSize.width /1.6) ,
                                      leftClaw3.position.y -     (leftClaw3.contentSize.height /1.2),
                                      leftClaw3.contentSize.width,
                                      leftClaw3.contentSize.height);
    
    CGRect leftClawRect4 = CGRectMake(leftClaw4.position.x -     (leftClaw4.contentSize.width /1.6) ,
                                      leftClaw4.position.y -     (leftClaw4.contentSize.height /1.2),
                                      leftClaw4.contentSize.width,
                                      leftClaw4.contentSize.height);
    
    CGRect leftClawRect5 = CGRectMake(leftClaw5.position.x -     (leftClaw5.contentSize.width /1.6) ,
                                      leftClaw5.position.y -     (leftClaw5.contentSize.height /1.2),
                                      leftClaw5.contentSize.width,
                                      leftClaw5.contentSize.height);

    CGRect leftClawRect6 = CGRectMake(leftClaw6.position.x -     (leftClaw6.contentSize.width /1.6) ,
                                      leftClaw6.position.y -     (leftClaw6.contentSize.height /1.2),
                                      leftClaw6.contentSize.width,
                                      leftClaw6.contentSize.height);
    
    CGRect leftClawRect7 = CGRectMake(leftClaw7.position.x -     (leftClaw7.contentSize.width /1.6) ,
                                      leftClaw7.position.y -     (leftClaw7.contentSize.height /1.2),
                                      leftClaw7.contentSize.width,
                                      leftClaw7.contentSize.height);
    
    
    
    
    
    
    CGRect rightClawRect0 = CGRectMake(rightClaw0.position.x -     (rightClaw0.contentSize.width /2.5) ,
                                       rightClaw0.position.y -     (rightClaw0.contentSize.height /1.2),
                                       rightClaw0.contentSize.width,
                                       rightClaw0.contentSize.height);
    
    CGRect rightClawRect1 = CGRectMake(rightClaw1.position.x -     (rightClaw1.contentSize.width /2.5) ,
                                      rightClaw1.position.y -     (rightClaw1.contentSize.height /1.2),
                                      rightClaw1.contentSize.width,
                                      rightClaw1.contentSize.height);
    
    CGRect rightClawRect2 = CGRectMake(rightClaw2.position.x -     (rightClaw2.contentSize.width /2.5) ,
                                       rightClaw2.position.y -     (rightClaw2.contentSize.height /1.2),
                                       rightClaw2.contentSize.width,
                                       rightClaw2.contentSize.height);
    
    CGRect rightClawRect3 = CGRectMake(rightClaw3.position.x -     (rightClaw3.contentSize.width /2.5) ,
                                       rightClaw3.position.y -     (rightClaw3.contentSize.height /1.2),
                                       rightClaw3.contentSize.width,
                                       rightClaw3.contentSize.height);
    
    CGRect rightClawRect4 = CGRectMake(rightClaw4.position.x -     (rightClaw4.contentSize.width /2.5) ,
                                       rightClaw4.position.y -     (rightClaw4.contentSize.height /1.2),
                                       rightClaw4.contentSize.width,
                                       rightClaw4.contentSize.height);
    
    CGRect rightClawRect5 = CGRectMake(rightClaw5.position.x -     (rightClaw5.contentSize.width /2.5) ,
                                       rightClaw5.position.y -     (rightClaw5.contentSize.height /1.2),
                                       rightClaw5.contentSize.width,
                                       rightClaw5.contentSize.height);
    
    CGRect rightClawRect6 = CGRectMake(rightClaw6.position.x -     (rightClaw6.contentSize.width /2.5) ,
                                       rightClaw6.position.y -     (rightClaw6.contentSize.height /1.2),
                                       rightClaw6.contentSize.width,
                                       rightClaw6.contentSize.height);
    
    CGRect rightClawRect7 = CGRectMake(rightClaw7.position.x -     (rightClaw7.contentSize.width /2.5) ,
                                       rightClaw7.position.y -     (rightClaw7.contentSize.height /1.2),
                                       rightClaw7.contentSize.width,
                                       rightClaw7.contentSize.height);

    
    
    if (CGRectIntersectsRect(leftClawRect0, rightClawRect0)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect1, rightClawRect1)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect2, rightClawRect2)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect3, rightClawRect3)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect4, rightClawRect4)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect5, rightClawRect5)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect6, rightClawRect6)) {
                [self playSmash];
        } else if (CGRectIntersectsRect(leftClawRect7, rightClawRect7)) {
                [self playSmash];
        }
    
    
    if (CGRectIntersectsRect(playerRect, leftClawRect0)) {
        
        if (_isBroken == YES) {
            return;
        }
       
        [[SimpleAudioEngine sharedEngine] playEffect:@"knifeCut.wav"];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];

    } else if (CGRectIntersectsRect(playerRect, leftClawRect1)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, leftClawRect2)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
    }
    else if (CGRectIntersectsRect(playerRect, leftClawRect3)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
    }
    else if (CGRectIntersectsRect(playerRect, leftClawRect4)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, leftClawRect5)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, leftClawRect6)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, leftClawRect7)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
    }
    
    
    
   if (CGRectIntersectsRect(playerRect, rightClawRect0)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
       
    } else if (CGRectIntersectsRect(playerRect, rightClawRect1)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect2)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect3)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect4)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect4)) {
        
            if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect5)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect6)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
        
    } else if (CGRectIntersectsRect(playerRect, rightClawRect7)) {
        
        if (_isBroken == YES) {
            return;
        }
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"crush.wav"];
        [self removeChild:scoreLabel cleanup: YES];
        [self removeChild:player cleanup: YES];
        [self removeChild:highscoreBG cleanup:YES];
        [[CCDirector sharedDirector] pause];
        [self showAlert];
    }
    
    
}




-(void) update:(ccTime)delta {
  
    [self checkForCollisions];
    
    if ([CCDirector sharedDirector].totalFrames % 60 == 0)
	{
		score++;
		[scoreLabel setString:[NSString stringWithFormat:@"%i", score]];
	}

    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    
    float maxX = screenSize.width - player.contentSize.width/2;
    float minX = player.contentSize.width/2;
    float maxY = screenSize.height - player.contentSize.height/1.2;
    float minY = player.contentSize.height/2;
    
    
    
    //keeps player within screen size
    
    if (player.position.x > maxX)
    {
        player.position = ccp(maxX, player.position.y);
    }
    else if (player.position.x < minX)
    {
        player.position = ccp(minX, player.position.y);
    }
    
    
    if (player.position.y > maxY)
    {
        player.position = ccp(player.position.x, maxY);
    }
    else if (player.position.y < minY)
    {
        player.position = ccp(player.position.x, minY);
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    
        if (score > [fetchDefaults integerForKey:@"highscore"]) {
            [defaults setInteger:score forKey:@"highscore"];
            
            //enter code for green highscore block + sound!
            
            if (!_beatHighscore) {
                highscoreBG = [CCSprite spriteWithFile:@"highscoreBG2.png"];
                highscoreBG.position = CGPointMake(screenSize.width / 2, screenSize.height);
                [self addChild:highscoreBG z:1];
                AudioServicesPlaySystemSound(highscoreSoundEffect);
                _beatHighscore = YES;
            }
        }
    
   
    
}



-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    
}


@end
