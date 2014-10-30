//
//  AppDelegate.h
//  DoodleClaw
//
//  Created by HoodsDream on 10/18/13.
//  Copyright 2013 AsteroidBlues All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"


@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
}

@property (nonatomic) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end
