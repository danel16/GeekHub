//
//  PLAPIClient.m
//  PodcastListener
//
//  Created by Misha on 02.12.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLAPIClient.h"
#import "GDataXMLNode.h"
#import "PLPodcastItem.h"
#import "PLPodcast+ParseResponse.h"
#import "PLPodcast.h"
#import "PLDataManager.h"

@implementation PLAPIClient

+(void)podcastFromURL:(NSURL *)url withCompletion:(void (^)(PLPodcast *))completion {
    PLDataManager *dbManager = [PLDataManager sharedInstance];
    NSArray *podcastsFromDB = [dbManager getPodcastsFromDB];
    
    if (podcastsFromDB.count > 0) {
        PLPodcast *podcasts = [[PLPodcast alloc] init];
        podcasts.items = podcastsFromDB;
        if (completion) {
            completion(podcasts);
        }
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            } else {
                GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
                NSArray *XMLItems = [doc nodesForXPath:@"//channel/item" error:&error];
                PLPodcast *podcasts = [[PLPodcast alloc] init];
                NSMutableArray *items = [NSMutableArray new];
                for (GDataXMLElement *item in XMLItems) {
                    PLPodcastItem *podcast = [PLPodcastItem parseFromXML:item];
                    [items addObject:podcast];
                    [dbManager addPodcastItemToDB:podcast];
                }
                podcasts.items = items;
                if (completion) {
                    completion(podcasts);
                }
            }
        }];
    }
}

@end
