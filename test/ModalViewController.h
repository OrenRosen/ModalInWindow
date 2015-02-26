//
//  ModalViewController.h
//  test
//
//  Created by Oren Rosenblum on 2/14/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewControllerDelegate <NSObject>

- (void)modalViewControllerDidClose;

@end

@interface ModalViewController : UIViewController

@property (nonatomic) BOOL canRotate;

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;


@end
