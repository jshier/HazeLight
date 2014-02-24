//
//  HLTDetailViewController.h
//  HazeLight
//
//  Created by Jon Shier on 2/27/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

@import UIKit;

@interface HLTDetailViewController : UIViewController

@property (nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
