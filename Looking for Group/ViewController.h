//
//  ViewController.h
//  Looking for Group
//
//  Created by Harminder Singh on 11/20/15.
//  Copyright (c) 2015 Harminder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "ProfileViewController.h"
@class Model;

@interface ViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView * FBLogin;

@property (strong, nonatomic) ProfileViewController *profileVC;

@property (strong, nonatomic) Model *model;


@end

