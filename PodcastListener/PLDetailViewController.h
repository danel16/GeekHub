//
//  PLDetailViewController.h
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLPodcastItem.h"
#import <AVFoundation/AVFoundation.h>

@interface PLDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIImageView *podcastImageView;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (strong, nonatomic) PLPodcastItem *podcast;
- (IBAction)playButtonTapped:(id)sender;
- (IBAction)seekForward:(id)sender;

@end
