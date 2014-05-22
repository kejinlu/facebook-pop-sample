//
//  MasterViewController.m
//  facebook-pop-sample
//
//  Created by Luke on 5/20/14.
//  Copyright (c) 2014 geeklu. All rights reserved.
//

#import "MasterViewController.h"

#import "BasicAnimationViewController.h"
#import "SpringAnimationViewController.h"
#import "DecayAnimationViewController.h"
#import "InteractiveAnimationViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.clipsToBounds = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.frame = self.view.bounds;
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Pop测试";
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
        [_objects addObject:@"Basic Animation"];
        [_objects addObject:@"Spring Animation"];
        [_objects addObject:@"Decay Animation"];
        [_objects addObject:@"Interactive Animation"];

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BasicAnimationViewController *detail = [[BasicAnimationViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    } else if (indexPath.row == 1) {
        SpringAnimationViewController *detail = [[SpringAnimationViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    } else if (indexPath.row == 2) {
        DecayAnimationViewController *detail = [[DecayAnimationViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    } else if (indexPath.row == 3) {
        InteractiveAnimationViewController *detail = [[InteractiveAnimationViewController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
