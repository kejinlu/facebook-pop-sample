//
//  InteractiveAnimationViewController.m
//  facebook-pop-sample
//
//  Created by Luke on 5/21/14.
//  Copyright (c) 2014 geeklu. All rights reserved.
//

#import "InteractiveAnimationViewController.h"
#import "Pop.h"

@interface InteractiveAnimationViewController ()

@end

@implementation InteractiveAnimationViewController


- (void)panHandler:(UIPanGestureRecognizer*)recognizer
{
    CGPoint velocity = [recognizer velocityInView:self.view];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    positionAnimation.dynamicsTension = 5;
    positionAnimation.dynamicsFriction = 5.0f;
    positionAnimation.springBounciness = 20.0f;
    [self.testView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    
    
    POPSpringAnimation *sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    sizeAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    sizeAnimation.springBounciness = 1.0f;
    sizeAnimation.dynamicsFriction = 1.0f;
    [self.testView.layer pop_addAnimation:sizeAnimation forKey:@"sizeAnimation"];
}


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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
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
