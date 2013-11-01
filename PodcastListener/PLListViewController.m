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

@interface PLListViewController ()

@property (nonatomic, strong) GDataXMLDocument *doc;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation PLListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    GDataXMLElement *item = self.items[indexPath.row];
    NSArray *titles = [item elementsForName:@"title"];
    if (titles.count > 0) {
        GDataXMLElement *title = titles[0];
        cell.titleLabel.text = title.stringValue;
    }
    
    NSArray *images = [item elementsForName:@"itunes:image"];
    if (images.count > 0) {
        GDataXMLElement *image = images[0];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[image attributeForName:@"href"] stringValue]]];
        cell.podcastImage.image = [UIImage imageWithData:imageData];
    }
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

    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
            _items = [self.doc nodesForXPath:@"//channel/item" error:&error];
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
