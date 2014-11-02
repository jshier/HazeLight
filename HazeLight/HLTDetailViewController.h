//
//  DetailViewController.h
//  HazeLight
//
//  Created by Jon Shier on 11/2/14.
//  Copyright (c) 2014 Jon Shier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTDetailViewController : UIViewController

@property (nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

