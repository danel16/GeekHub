//
//  PLAppDelegate.h
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLListViewController;

@interface PLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PLListViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
