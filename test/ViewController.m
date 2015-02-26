//
//  ViewController.m
//  test
//
//  Created by Oren Rosenblum on 2/13/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "ViewController.h"
#import "nav.h"

#import "ModalViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ModalViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) UIWindow *topWindow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view bringSubviewToFront:self.button];
    [self.view bringSubviewToFront:self.topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell number %ld", (long)indexPath.row];
    
    return cell;
}


- (IBAction)openButtonClicked:(id)sender
{
    
    ModalViewController *modal = [self createModalViewController];
    [self createTopWindow];

    self.topWindow.rootViewController = modal;
    
    [self presentTopWindowAsModalViewController];
}



- (ModalViewController *)createModalViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ModalViewController *modal = [sb instantiateViewControllerWithIdentifier:@"modal"];
    modal.delegate = self;
    modal.view.alpha = 0.8;
    return modal;
}


- (void)createTopWindow
{
    self.topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.topWindow.backgroundColor = [UIColor greenColor];
    self.topWindow.windowLevel = UIWindowLevelNormal;
    self.topWindow.alpha = 0.8;
    self.topWindow.hidden = NO;
}


- (void)presentTopWindowAsModalViewController
{
    CGRect originalFramr = self.topWindow.frame;
    CGRect fr = self.topWindow.frame;
    fr.origin.y = self.view.frame.size.height;
    self.topWindow.frame = fr;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.topWindow.frame = originalFramr;
    }];
}



- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}




- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (void)modalViewControllerDidClose
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect fr = self.topWindow.frame;
        fr.origin.y = self.view.frame.size.height;
        self.topWindow.frame = fr;
    } completion:^(BOOL finished) {
        
        [[[UIApplication sharedApplication] delegate].window makeKeyAndVisible];
        self.topWindow.hidden = YES;
        self.topWindow.rootViewController = nil;
        self.topWindow = nil;
        
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    }];
}

@end
