//
//  PLPodcast+ParseFromXML.h
//  PodcastListener
//
//  Created by Misha on 10.11.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLPodcast.h"
#import "GDataXMLNode.h"

@interface PLPodcast (ParseResponse)

+(PLPodcast*) parseFromXML: (GDataXMLElement *)item;

@end
