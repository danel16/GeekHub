//
//  PLViewController.m
//  PodcastListener
//
//  Created by Misha on 19.10.13.
//  Copyright (c) 2013 Misha. All rights reserved.
//

#import "PLListViewController.h"
#import "PLDetailViewController.h"
@interface PLListViewController ()

@end

@implementation PLListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

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
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Podcast #%i", indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PLDetailViewController *detailView = [[PLDetailViewController alloc] initWithNibName:@"PLDetailViewController" bundle:nil];
    detailView.labelText = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    NSLog(@"************ %@", [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]);
    [self.navigationController pushViewController:detailView animated:YES];
}
@end
