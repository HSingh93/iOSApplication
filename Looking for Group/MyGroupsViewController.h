//
//  MyGroupsViewController.h
//  Looking for Group
//
//  Created by Harminder Singh on 12/4/15.
//  Copyright © 2015 Harminder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <parse/Parse.h>

@interface MyGroupsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) NSString *userID;

@end
