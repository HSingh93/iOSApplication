//
//  ViewController.m
//  Looking for Group
//
//  Created by Harminder Singh on 11/20/15.
//  Copyright (c) 2015 Harminder Singh. All rights reserved.
//

#import "ViewController.h"
#import "ProfileViewController.h"
#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize model;
@synthesize profileVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if(model == nil) {
        model = [[Model alloc] init];
        model.loggedIn = 0;
    }
    
    if(profileVC == nil) {
        profileVC = (ProfileViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
        profileVC.model = model;
    }
    
    self.FBLogin.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"%@", user.name);
    
}
     
-(void) loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    model.loggedIn = 1;
    profileVC.model.loggedIn = 1;
    NSLog(@"You have logged in! %d", model.loggedIn);
    //Change to profile view
    [self presentViewController:profileVC animated:YES completion:nil];
    
}

-(void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"You have logged out! %d", model.loggedIn);
    
}

-(void) loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    
    NSString *alertMSG, *alertTitle;
    
    if([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook Error";
        alertMSG = [FBErrorUtility userMessageForError:error];
    }
    
    else if([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMSG = @"Your current session isn't valid. Please log in again.";
    }
    
    else if([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"User cancelled log in");
    }
    
    else {
        alertTitle = @"An error has occurred";
        alertMSG = @"Please try again.";
        NSLog(@"Unexpected error occurred: %@", error);
    }
    
    if(alertMSG) {
        [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMSG delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
}

@end
