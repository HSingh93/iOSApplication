//
//  ProfileViewController.h
//  Looking for Group
//
//  Created by Harminder Singh on 11/21/15.
//  Copyright © 2015 Harminder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class Model;

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBLoginView *Logout;
@property (strong, nonatomic) Model *model;

@end
