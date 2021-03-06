//
//  AppDelegate.m
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate () {
    AVAudioPlayer *launchSoundPlayer;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self playLaunchSound];

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)] ;
    
    // assign Main view controller
    _mVC = [[MainViewController alloc] init];
    
    // assign nav controller
    _nav = [[UINavigationController alloc]  initWithRootViewController:_mVC];
    _nav.navigationBarHidden = true;
    // assign the rootview controller to the nav controller and display it
    _window.rootViewController = _nav;
    [_window makeKeyAndVisible];
    //[_nav presentViewController:_splashscreenVC animated:nil completion:nil];
    //[_nav performSelector:@selector(dismissModalViewControllerAnimated:) withObject:nil afterDelay:3.0];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)playLaunchSound {
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/KeeyStartSoundlow.wav",
                               [[NSBundle mainBundle] resourcePath]];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    launchSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    //[launchSoundPlayer play];
}

@end
