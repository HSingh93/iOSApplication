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
@synthesize saveText;
@synthesize description;

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
                    NSString *urlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", self.userID];
                    NSLog(@"%@", urlString);
                    
                    NSURL *imageURL = [NSURL URLWithString:urlString];
                    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                    UIImage * image = [UIImage imageWithData:imageData];
                    //UIImageView * picture = [[UIImageView alloc] initWithImage:image];
                    //[picture setContentMode:UIViewContentModeCenter];
                    //[self.profilePicture addSubview:picture];
                    
                    [profileImage setContentMode:UIViewContentModeScaleAspectFit];
                    [profileImage setImage:image];
                    
                    NSLog(@"%@", UserObj[@"username"]);
                    
                }];
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    //Get user description
    PFQuery *queryDescription = [PFQuery queryWithClassName:@"UserDescription"];
    [queryDescription whereKey:@"userField" equalTo:self.userID];
    
    [queryDescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"ID %@", object.objectId);
                NSString * objID = object.objectId;
                
                [queryDescription getObjectInBackgroundWithId:objID block:^(PFObject *UserDescription, NSError *error) {
                    // Do something with the returned PFObject in the gameScore variable.
                    //NSLog(@"Text %@", UserDescription[@"userText"]);
                    description.text = UserDescription[@"userText"];
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

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"START");
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = -100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    return YES;
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"END");
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)saveDescription:(id)sender {
    if(description.text.length > 0) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"UserDescription"];
        [query whereKey:@"userField" equalTo:self.userID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d scores.", objects.count);
                // Do something with the found objects
                if(objects.count < 1) {
                    NSLog(@"Putting into description DB");
                    PFObject *userObj = [PFObject objectWithClassName:@"UserDescription"];
                    userObj[@"userField"] = self.userID;
                    userObj[@"userText"] = description.text;
                    [userObj saveInBackground];
                }
                else {
                    NSLog(@"Replace the text!");
                    for (PFObject *object in objects) {
                        NSLog(@"ID %@", object.objectId);
                        
                        PFObject *obj = [PFObject objectWithoutDataWithClassName:@"UserDescription" objectId:object.objectId];
                        [obj setObject:description.text forKey:@"userText"];
                        [obj save];
                    }
                }
            }
            else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
    }
    
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
