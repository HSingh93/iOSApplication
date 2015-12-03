//
//  ProfileViewController.m
//  Looking for Group
//
//  Created by Harminder Singh on 12/2/15.
//  Copyright © 2015 Harminder Singh. All rights reserved.
//

#import "ProfileViewController.h"
#import "ViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize profileImage;
@synthesize userName;
@synthesize model;
@synthesize userID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", userID);
    PFQuery *query = [PFQuery queryWithClassName:@"UserObj"];
    [query whereKey:@"userField" equalTo:self.userID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSString * objID = object.objectId;
                
                [query getObjectInBackgroundWithId:objID block:^(PFObject *UserObj, NSError *error) {
                    // Do something with the returned PFObject in the gameScore variable.
                    userName.text = UserObj[@"username"];
                    NSLog(@"%@", UserObj[@"username"]);
                }];
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
