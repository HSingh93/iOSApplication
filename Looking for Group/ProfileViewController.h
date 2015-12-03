//
//  ProfileViewController.h
//  Looking for Group
//
//  Created by Harminder Singh on 12/2/15.
//  Copyright © 2015 Harminder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <parse/Parse.h>
#import "Model.h"

@interface ProfileViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (strong, nonatomic) Model *model;

@property (weak, nonatomic) NSString *userID;

@property (weak, nonatomic) IBOutlet UITextField *description;

@property (weak, nonatomic) IBOutlet UIButton *saveText;


@end
