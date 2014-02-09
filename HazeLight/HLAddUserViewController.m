//
//  HLAddUserViewController.m
//  HazeLight
//
//  Created by Jon Shier on 3/2/13.
//  Copyright (c) 2013 Jon Shier. All rights reserved.
//

#import "HLAddUserViewController.h"

@implementation HLAddUserViewController

- (void)viewWillAppear:(BOOL)animated
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    NSLog(@"Pasteboard types: %@", [pb pasteboardTypes]);
    if ([[pb pasteboardTypes] containsObject:@"public.utf8-plain-text"])
    {
        NSLog(@"Appropriate pasteboard type.");
        NSString *possibleAPIKey = [[NSString alloc] initWithData:[pb dataForPasteboardType:@"public.utf8-plain-text"] encoding:NSUTF8StringEncoding];
        
        if (possibleAPIKey.length == 37 && [[possibleAPIKey stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]] isEqualToString:@""])
        {
            NSLog(@"Appropriate length and characters.");
            UIAlertView *alertView = [[UIAlertView alloc] init];
            alertView.title = @"Possible API Key Detected";
            alertView.message = [NSString stringWithFormat:@"A key was detected on your clipboard.\nWould you like to use %@ as your API key?", possibleAPIKey];
            alertView.delegate = self;
            [alertView addButtonWithTitle:@"No"];
            [alertView addButtonWithTitle:@"Yes"];
            alertView.cancelButtonIndex = 0;
            [alertView show];
            
        }
        
        NSLog(@"Possible API Key: %@", possibleAPIKey);
        NSLog(@"Key length: %lu", (unsigned long)[possibleAPIKey length]);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex)
        self.apiKey.text = [[NSString alloc] initWithData:[[UIPasteboard generalPasteboard] dataForPasteboardType:@"public.utf8-plain-text"] encoding:NSUTF8StringEncoding];
}

@end
