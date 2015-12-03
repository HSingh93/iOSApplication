//
//  ViewController.m
//  Looking for Group
//
//  Created by Harminder Singh on 11/20/15.
//  Copyright (c) 2015 Harminder Singh. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "ProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize model;
@synthesize findGroupButton;
@synthesize createGroupButton;
@synthesize myGroupButton;
@synthesize viewProfileButton;
@synthesize userID;
@synthesize exists;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if(model == nil) {
        model = [[Model alloc] init];
        model.loggedIn = 0;
    }
    self.FBLogin.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"%@", user.name);
    userID = user.id;
    PFQuery *query = [PFQuery queryWithClassName:@"UserObj"];
    [query whereKey:@"userField" equalTo:user.id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            if(objects.count < 1) {
                NSLog(@"Putting into DB");
                PFObject *userObj = [PFObject objectWithClassName:@"UserObj"];
                userObj[@"username"] = user.name;
                userObj[@"userField"] = user.id;
                userObj[@"userImage"] = @"Logo.png";
                [userObj saveInBackground];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    

    
}
     
-(void) loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    model.loggedIn = 1;
    NSLog(@"You have logged in! %d", model.loggedIn);
    //Change to profile view
    //[self presentViewController:profileVC animated:YES completion:nil];
    
    findGroupButton.hidden = NO;
    createGroupButton.hidden = NO;
    myGroupButton.hidden = NO;
    viewProfileButton.hidden = NO;
    
    
}

-(void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"You have logged out! %d", model.loggedIn);
    
    findGroupButton.hidden = YES;
    createGroupButton.hidden = YES;
    myGroupButton.hidden = YES;
    viewProfileButton.hidden = YES;
    
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"profile"])
    {
        ProfileViewController * viewController = [segue destinationViewController];
        viewController.userID = self.userID;
    }
    
}

- (IBAction)viewProfile:(id)sender {
    
}

@end
