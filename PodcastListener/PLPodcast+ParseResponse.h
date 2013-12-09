//
//  PLPodcast+ParseFromXML.h
//  PodcastListener
//
//  Created by Misha on 10.11.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLPodcastItem.h"
#import "GDataXMLNode.h"

@interface PLPodcastItem (ParseResponse)

+(PLPodcastItem*) parseFromXML: (GDataXMLElement *)item;

@end
