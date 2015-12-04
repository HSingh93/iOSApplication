//
//  MyGroupsViewController.m
//  Looking for Group
//
//  Created by Harminder Singh on 12/4/15.
//  Copyright © 2015 Harminder Singh. All rights reserved.
//

#import "MyGroupsViewController.h"
#import "ViewController.h"

@interface MyGroupsViewController ()

@end

@implementation MyGroupsViewController

@synthesize returnButton;
@synthesize titleText;
@synthesize userID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    returnButton.layer.cornerRadius = 10; // this value vary as per your desire
    returnButton.clipsToBounds = YES;
    [[returnButton layer] setBorderWidth:2.0f];
    [[returnButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    NSLog(@"UserID: %@", userID);
    
    //----QUERY GROUPS TABLE AND DISPLAY GROUP RESULTS!
    
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
                    titleText.text = [NSString stringWithFormat:@"%@'s Groups",UserObj[@"username"]];
                    
                }];
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"returnFromProfile"])
    {
        ViewController * viewController = [segue destinationViewController];
        viewController.userID = self.userID;
    }
    
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
