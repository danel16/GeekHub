//
//  PLPodcast+ParseFromXML.m
//  PodcastListener
//
//  Created by Misha on 10.11.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLPodcast+ParseResponse.h"
#import "GDataXMLNode.h"

@implementation PLPodcast (ParseResponse)

+(PLPodcast*) parseFromXML: (GDataXMLElement *)item {
    PLPodcast *parsedPodcast = [[PLPodcast alloc] init];
    
    NSArray *titles = [item elementsForName:@"title"];
    if (titles.count > 0) {
        GDataXMLElement *title = titles[0];
        parsedPodcast.title = title.stringValue;
    }
    
    NSArray *images = [item elementsForName:@"itunes:image"];
    if (images.count > 0) {
        GDataXMLElement *image = images[0];
        parsedPodcast.imageUrl = [[image attributeForName:@"href"] stringValue];
    }
    
    NSArray *audioUrls = [item elementsForName:@"enclosure"];
    if (audioUrls.count > 0) {
        GDataXMLElement *audioUrl = audioUrls[0];
        parsedPodcast.url = [[audioUrl attributeForName:@"url"] stringValue];
    }
    
    return parsedPodcast;
}

@end
