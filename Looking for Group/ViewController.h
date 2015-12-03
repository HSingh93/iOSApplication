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
#import <parse/Parse.h>

@class Model;

@interface ViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView * FBLogin;

@property (strong, nonatomic) Model *model;

@property (weak, nonatomic) IBOutlet UIButton *findGroupButton;
@property (weak, nonatomic) IBOutlet UIButton *createGroupButton;
@property (weak, nonatomic) IBOutlet UIButton *myGroupButton;
@property (weak, nonatomic) IBOutlet UIButton *viewProfileButton;
@property (weak, nonatomic) NSString *userID;
@property (nonatomic) NSArray * exists;

@end

