//
//  PLDetailViewController.m
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PLPodcast.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PLDetailViewController ()

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
    
//    self.podcastImageView.image = [UIImage imageNamed:@"navigation_background"];
    [self.podcastImageView setImageWithURL:[NSURL URLWithString:self.podcast.imageUrl]];
    [self.podcastImageView.layer setMasksToBounds:YES];
    [self.podcastImageView.layer setCornerRadius:6.0f];
    
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"slider-thumb-image"] forState:UIControlStateNormal];
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"slider-thumb-image"] forState:UIControlStateHighlighted];
    [self.progressSlider setMinimumTrackImage:[[UIImage imageNamed:@"slider-progress"] stretchableImageWithLeftCapWidth:9 topCapHeight:0] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[[UIImage imageNamed:@"slider-base-progress"] stretchableImageWithLeftCapWidth:9 topCapHeight:0] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
