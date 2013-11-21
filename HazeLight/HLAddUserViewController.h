//
//  HLAddUserViewController.h
//  HazeLight
//
//  Created by Jon Shier on 3/2/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLAddUserViewController : UIViewController <UIAlertViewDelegate>

@property (weak) IBOutlet UITextField *email;
@property (weak) IBOutlet UITextField *apiKey;

@end
