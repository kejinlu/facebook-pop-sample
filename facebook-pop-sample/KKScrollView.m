//
//  KKScrollView.m
//  facebook-pop-sample
//
//  Created by Luke on 5/20/14.
//  Copyright (c) 2014 geeklu. All rights reserved.
//

#import "KKScrollView.h"
#import <POP.h>

@interface KKScrollView ()
@property CGRect startBounds;
@end

@implementation KKScrollView

#pragma mark -
#pragma mark Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitForCustomScrollView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self commonInitForCustomScrollView];
    }
    return self;
}

- (void)commonInitForCustomScrollView
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:panGestureRecognizer];
}


#pragma mark -
#pragma mark GestureRecognizer Handler

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self pop_removeAnimationForKey:@"decelerateAnimation"];
            [self pop_removeAnimationForKey:@"resetAnimation"];
            
            self.startBounds = self.bounds;
        }

        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [panGestureRecognizer translationInView:self];
            CGRect bounds = self.startBounds;

            CGFloat newBoundsOriginX = bounds.origin.x - translation.x;
            CGFloat minBoundsOriginX = 0.0;
            CGFloat maxBoundsOriginX = self.contentSize.width - bounds.size.width;
            bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX));

        
            CGFloat newBoundsOriginY = bounds.origin.y - translation.y;
            CGFloat minBoundsOriginY = 0.0;
            CGFloat maxBoundsOriginY = self.contentSize.height - bounds.size.height;
            bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY));
            bounds.origin.y = newBoundsOriginY;
            self.bounds = bounds;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint velocity = [panGestureRecognizer velocityInView:self];
            if (self.bounds.size.width >= self.contentSize.width) {
                velocity.x = 0;
            }
            if (self.bounds.size.height >= self.contentSize.height) {
                velocity.y = 0;
            }
            velocity.x = -velocity.x;
            velocity.y = -velocity.y;
            NSLog(@"velocity: %@", NSStringFromCGPoint(velocity));

            POPDecayAnimation *decayAnimation = [POPDecayAnimation animation];
            

            POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"com.rounak.bounds.origin" initializer:^(POPMutableAnimatableProperty *prop) {
                // read value
                prop.readBlock = ^(id obj, CGFloat values[]) {
                    NSLog(@"readBlock values: %f", values[1]);
                    values[0] = [obj bounds].origin.x;
                    values[1] = [obj bounds].origin.y;
                };
                // write value
                prop.writeBlock = ^(id obj, const CGFloat values[]) {
                    CGRect tempBounds = [obj bounds];
                    NSLog(@"writeBlock values: %f", values[1]);
                    tempBounds.origin.x = values[0];
                    tempBounds.origin.y = values[1];
                    [obj setBounds:tempBounds];
                    
                    if (values[1] < 0 || values[1] > ([obj contentSize].height - [obj bounds].size.height)) {
                        decayAnimation.deceleration = 0.92;
                    }
                };
                // dynamics threshold
                prop.threshold = 0.01;
            }];
            
            __weak KKScrollView *weakSelf = self;
            decayAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
                if (weakSelf.bounds.origin.y < 0 || weakSelf.bounds.origin.y > weakSelf.contentSize.height - weakSelf.bounds.size.height) {
                    CGRect tempBounds = [weakSelf bounds];
                    
                    if (weakSelf.bounds.origin.y < 0) {
                        tempBounds.origin.y = 0;
                    } else {
                        tempBounds.origin.y = weakSelf.contentSize.height - tempBounds.size.height;
                    }
                    
                    POPBasicAnimation *resetAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBounds];
                    resetAnimation.toValue = [NSValue valueWithCGRect:tempBounds];
                    [weakSelf pop_addAnimation:resetAnimation forKey:@"resetAnimation"];
                
                }
            };
            decayAnimation.property = prop;
            decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
            [self pop_addAnimation:decayAnimation forKey:@"decelerateAnimation"];
        }
            break;

        default:
            break;
    }

}

@end
