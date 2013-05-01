//
//  KKCustomSegue.m
//  CustomModalSegue
//
//  Created by Kinshuk Kar on 01/05/13.
//  Copyright (c) 2013 Kinshuk Kar. All rights reserved.
//

#import "KKCustomSegue.h"
#import <QuartzCore/QuartzCore.h>

@implementation KKCustomSegue

- (void)perform
{
    //Getting the source and the destination controller
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationViewController = (UIViewController*)[self destinationViewController];
    
    //Setting the initial view based on whether the source controller is wrapper in a navigation controller or not
    UIView *initialView = sourceViewController.navigationController == nil ? sourceViewController.view : sourceViewController.navigationController.view;
    
    //The initial transform is just a translation (Pushing the view slightly behind). To avoid overlapping views during transition
    CATransform3D initialTransform = CATransform3DMakeTranslation(0, 0, -10);
    
    //Rotation of 60 degrees around the x axis
    CATransform3D finalTransform = CATransform3DMakeRotation(M_PI/6, 1, 0, 0);
    
    //The m34 is used for setting the perspective, the position of the camera. 1/200 here means that the camera is 200 point in front of the view
    finalTransform.m34 = 1.0/200.0;
    
    //Setting the animation parameters. From and To transforms, duration, timing function, etc
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    initialView.layer.transform = initialTransform;
    [animation setFromValue:[NSValue valueWithCATransform3D:initialTransform]];
    [animation setToValue:[NSValue valueWithCATransform3D:finalTransform]];
    [animation setDuration:.8];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:YES];
    [animation setDelegate:self];
    
    //Setting the anchor point and position of the layer to be at the lower middle of the view for the transformation
    //Position has to be set to be in sync with anchor point. First time shifting issue.
    //Also, the position has to be based on the device orientation
    initialView.layer.position = [KKCustomSegue getPositionForOrientation:sourceViewController.interfaceOrientation andFrame:initialView.layer.frame];
    
    //Setting the anchor point. Anchor point is independent of the device orientation
    initialView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    
    //Setting the key to be transform to override the default and not cause conflicting animations
    [initialView.layer addAnimation:animation forKey:@"transform"];
    [sourceViewController presentViewController:destinationViewController animated:YES completion:^(void) {
        //Resetting the anchor point and position for rotation issue fix
        CGRect frame = initialView.layer.frame;
        CGPoint positionInFrame = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
        initialView.layer.position = positionInFrame;
        initialView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }];
}

//This method will give the
+ (CGPoint) getPositionForOrientation:(UIInterfaceOrientation)orientation andFrame:(CGRect)frame
{
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            return CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGPointMake(CGRectGetMidX(frame), CGRectGetMinY(frame));
        case UIInterfaceOrientationLandscapeLeft:
            return CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame));
        case UIInterfaceOrientationLandscapeRight:
            return CGPointMake(CGRectGetMinX(frame), CGRectGetMidY(frame));
        default:
            break;
    }
}

@end
