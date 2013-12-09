//
//  PLPodcastItem.h
//  PodcastListener
//
//  Created by Misha on 02.12.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLPodcastItem : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;

@end
