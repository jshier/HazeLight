//
//  ICFMasterViewController.m
//  iCloudFlare
//
//  Created by Jon Shier on 2/27/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLMasterViewController.h"
#import "HLDetailViewController.h"
#import "HLUser.h"
#import "HLAddUserViewController.h"

@interface HLMasterViewController ()

@property (strong, nonatomic) NSMutableArray *users;

@end

@implementation HLMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewUser:(UIStoryboardSegue *)segue
{
    if (!self.users) {
        self.users = [[NSMutableArray alloc] init];
    }
    HLAddUserViewController *addUserController = [segue sourceViewController];
    [self.users insertObject:[[HLUser alloc] initWithEmail:addUserController.email.text apiKey:addUserController.apiKey.text] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (IBAction)cancelAddNewUser:(UIStoryboardSegue *)segue
{
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = ((HLUser *)self.users[indexPath.row]).email;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.users removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.users[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
