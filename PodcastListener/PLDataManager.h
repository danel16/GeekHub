//
//  PLDataManager.h
//  PodcastListener
//
//  Created by Admin on 07.01.14.
//  Copyright (c) 2014 Misha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLPodcastItem.h"

@interface PLDataManager : NSObject

+ (PLDataManager *)sharedInstance;
- (NSArray*)getPodcastsFromDB;
- (void)addPodcastItemToDB:(PLPodcastItem *)podcastItem;

@end
