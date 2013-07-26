//
//  AppDelegate.h
//  drums
//
//  Created by John Fowler on 3/26/13.
//  Copyright (c) 2013 John Fowler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class ACConnection;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) ACConnection *appcoClient;

@end
