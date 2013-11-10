//
//  PLDetailViewController.h
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) NSString *labelText;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIImageView *podcastImageView;

@end
