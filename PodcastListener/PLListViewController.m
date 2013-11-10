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
    PLPodcast *podcast = _items[indexPath.row];
    cell.titleLabel.text = podcast.title;
    NSURL *imagaeURL = [NSURL URLWithString:podcast.imageUrl];
    [cell.podcastImage setImageWithURL:imagaeURL];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PLDetailViewController *detailView = [[PLDetailViewController alloc] initWithNibName:@"PLDetailViewController" bundle:nil];
    PLPodcastCell *cell = (PLPodcastCell*)[tableView cellForRowAtIndexPath:indexPath];
    detailView.labelText = cell.titleLabel.text;
    [self.navigationController pushViewController:detailView animated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([self checkConnection]) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"Please wait. Loading";
        [self getData];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    
    return YES;
}

-(void) getData {
    NSURL *requestUrl = [NSURL URLWithString:self.urlField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self.hud hide:YES];
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        } else {
            self.doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
            NSArray *XMLItems = [self.doc nodesForXPath:@"//channel/item" error:&error];
            for (GDataXMLElement *item in XMLItems) {
                PLPodcast *podcast = [PLPodcast parseFromXML:item];
                [self.items addObject:podcast];
            }
            [self.tableView reloadData];
            [self.hud hide:YES];
        }
    }];

}

-(BOOL) checkConnection {
    Reachability* wifiReach = [Reachability reachabilityForInternetConnection];
    return wifiReach.isReachable;
}

@end
