//
//  ModalViewController.m
//  test
//
//  Created by Oren Rosenblum on 2/14/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@" -----> modal did load");
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@" -----> modal WILL Appear");
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@" -----> modal did Appear");
    self.canRotate = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@" -----> modal will disappear");
    [super viewWillDisappear:animated];
}


- (void)dealloc
{
    NSLog(@" -----> modal ciew controller DEALLOC");
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (self.canRotate) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (IBAction)close:(id)sender
{
    CGFloat delay = 0;
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        delay = 0.3;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate modalViewControllerDidClose];
    });
}



@end
