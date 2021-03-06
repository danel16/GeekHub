//
//  PLDetailViewController.m
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PLPodcastItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

@interface PLDetailViewController (){
    AVPlayer *player;
}

@end

@implementation PLDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.detailLabel.text = self.podcast.title;
    [self.detailLabel sizeToFit];
    
    NSURL *podcastUrl = [NSURL URLWithString:self.podcast.url];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:podcastUrl options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        NSString  *path = [NSHomeDirectory() stringByAppendingPathComponent:[@"Documents/" stringByAppendingString:[self.podcast.url lastPathComponent]]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            NSLog(@"begin saving....");
            NSData *dbFile = [[NSData alloc] initWithContentsOfURL:podcastUrl];
            [dbFile writeToFile:path atomically:YES];
            NSLog(@"End saving file...");
        }
    });
    
    [self.podcastImageView setImageWithURL:[NSURL URLWithString:self.podcast.imageUrl]];
    [self.podcastImageView.layer setMasksToBounds:YES];
    [self.podcastImageView.layer setCornerRadius:6.0f];
    
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"slider-thumb-image"] forState:UIControlStateNormal];
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"slider-thumb-image"] forState:UIControlStateHighlighted];
    [self.progressSlider setMinimumTrackImage:[[UIImage imageNamed:@"slider-progress"] stretchableImageWithLeftCapWidth:9 topCapHeight:0] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[[UIImage imageNamed:@"slider-base-progress"] stretchableImageWithLeftCapWidth:9 topCapHeight:0] forState:UIControlStateNormal];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayer Ready to Play");
            [player play];
        } else if (player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}

-(void)playButtonTapped:(id)sender {
    if (player.rate == 1.0) {
        [player pause];
    } else {
        [player play];
    }
}

- (IBAction)seekForward:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
