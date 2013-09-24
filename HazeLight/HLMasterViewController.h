//
//  ICFMasterViewController.h
//  iCloudFlare
//
//  Created by Jon Shier on 2/27/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLMasterViewController : UITableViewController

- (IBAction)addNewUser:(UIStoryboardSegue *)segue;
- (IBAction)cancelAddNewUser:(UIStoryboardSegue *)segue;

@end
