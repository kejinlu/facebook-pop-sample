//
//  BasicAnimationViewController.m
//  facebook-pop-sample
//
//  Created by Luke on 5/20/14.
//  Copyright (c) 2014 geeklu. All rights reserved.
//

#import "BasicAnimationViewController.h"
#import "Pop.h"


@implementation BasicAnimationViewController


- (void)moveAction:(id)sender{
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    NSInteger height = CGRectGetHeight(self.view.bounds);
    NSInteger width = CGRectGetWidth(self.view.bounds);
    
    CGFloat centerX = arc4random() % width;
    CGFloat centerY = arc4random() % height;

    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.duration = 0.5;
    [self.testView pop_addAnimation:anim forKey:@"center"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStylePlain target:self action:@selector(moveAction:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
