//
//  DecayAnimationViewController.m
//  facebook-pop-sample
//
//  Created by Luke on 5/21/14.
//  Copyright (c) 2014 geeklu. All rights reserved.
//

#import "DecayAnimationViewController.h"
#import "KKScrollView.h"

@interface DecayAnimationViewController ()

@end

@implementation DecayAnimationViewController

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

    KKScrollView *scrollView = [[KKScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor grayColor];
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1500);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)];
    contentView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i< 10; i++) {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 150 * i, 200, 130)];
        testLabel.backgroundColor = [UIColor orangeColor];
        testLabel.text = [NSString stringWithFormat:@"%d",i];
        testLabel.font = [UIFont systemFontOfSize:50];
        testLabel.textAlignment = NSTextAlignmentCenter;
        testLabel.textColor = [UIColor whiteColor];
        [contentView addSubview:testLabel];
    }
    
    [scrollView addSubview:contentView];
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
