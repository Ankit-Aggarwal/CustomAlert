//
//  ViewController.m
//  CustomAlertView
//
//  Created by Ankit on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showAlertTapped:(id)sender {
    NSArray *buttonsText = [[NSArray alloc]initWithObjects:@"Button1",@"Button2",@"Button3",@"Button4",@"Button5",nil];
    [[[CustomAlertView alloc] initWithTitle:@"Title" message:@"Testing with 5 normal buttons and 1 cancel button and three line Message" andButtonsText:buttonsText andCancelButtonsText:@"ok" withDelegate:self]show];
}
#pragma  mark - CustomAlertView method


-(void)alertButtonTappedWithIndex:(int)index forView:(CustomAlertView*)view
{
    // index starts with 0
    NSLog(@"button tapped id %d",index);
}
@end
