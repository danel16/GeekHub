//
//  PLDetailViewController.m
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    self.detailLabel.text = self.labelText;
    [self.detailLabel sizeToFit];
    self.podcastImageView.image = [UIImage imageNamed:@"navigation_background.png"];
    [self.podcastImageView.layer setMasksToBounds:YES];
    [self.podcastImageView.layer setCornerRadius:5.0f];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
