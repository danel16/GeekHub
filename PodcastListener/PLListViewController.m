//
//  PLViewController.m
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLListViewController.h"
#import "PLDetailViewController.h"
#import "MBProgressHUD.h"
#import "PLPodcastCell.h"
#import "GDataXMLNode.h"
#import "Reachability.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PLPodcast+ParseResponse.h"
#import "PLPodcast.h"
#import "PLAPIClient.h"

@interface PLListViewController ()

@property (nonatomic, strong) GDataXMLDocument *doc;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation PLListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _items = [[NSMutableArray alloc] init];
    self.urlField.delegate = self;
    [self.urlField setReturnKeyType:UIReturnKeyDone];
    [self.tableView registerNib:[UINib nibWithNibName:@"PLPodcastCellView" bundle:nil] forCellReuseIdentifier:@"Cell"];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLPodcastCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[PLPodcastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    PLPodcastItem *podcast = _items[indexPath.row];
    cell.titleLabel.text = podcast.title;
    NSURL *imagaeURL = [NSURL URLWithString:podcast.imageUrl];
    [cell.podcastImage setImageWithURL:imagaeURL];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PLDetailViewController *detailView = [[PLDetailViewController alloc] initWithNibName:@"PLDetailViewController" bundle:nil];
    detailView.podcast = _items[indexPath.row];
    [self.navigationController pushViewController:detailView animated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([self checkConnection]) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"Please wait. Loading";
        NSURL *requestUrl = [NSURL URLWithString:self.urlField.text];
        [PLAPIClient podcastFromURL:requestUrl withCompletion:^(PLPodcast * podcasts) {
            self.items = podcasts.items;
            [self.tableView reloadData];
            [self.hud hide:YES];
        }];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    
    return YES;
}

-(BOOL) checkConnection {
    Reachability* wifiReach = [Reachability reachabilityForInternetConnection];
    return wifiReach.isReachable;
}

@end
