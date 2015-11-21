//
//  ProfileViewController.m
//  Looking for Group
//
//  Created by Harminder Singh on 11/21/15.
//  Copyright © 2015 Harminder Singh. All rights reserved.
//

#import "ProfileViewController.h"
#import "ViewController.h"
#import "Model.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize model;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Model: %d", model.loggedIn);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"You have logged out HERE!");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
