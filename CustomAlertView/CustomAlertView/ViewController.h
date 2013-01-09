//
//  ViewController.h
//  CustomAlertView
//
//  Created by Ankit on 9/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"
@interface ViewController : UIViewController<CustomAlertViewDelegate>

- (IBAction)showAlertTapped:(id)sender;
@end
