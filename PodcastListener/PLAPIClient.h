//
//  PLAPIClient.h
//  PodcastListener
//
//  Created by Misha on 02.12.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLPodcast.h"

@interface PLAPIClient : NSObject

+(void)podcastFromURL:(NSURL *) url withCompletion:(void (^) (PLPodcast *))cmopletion;

@end
