//
//  PLViewController.h
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
