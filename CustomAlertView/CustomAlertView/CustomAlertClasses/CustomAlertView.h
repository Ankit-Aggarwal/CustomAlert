//
//  CustomAlertView.h
//  test
//
//  Created by Ankit on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// Custom alert can be added by using following init method giving title , message and buttons text in an array and cancel button text
// and alert can be shown by using show() function
// any number of button can be sent maximum to 6
// view will change in length and title , message and all the buttons will get arranged as in native UIAlertView
// any property of alert can be customize ( title , message font and color buttons font color , background color )
//
//


#import <UIKit/UIKit.h>
#import "CustomAlertBox.h"
@protocol CustomAlertViewDelegate;

@interface CustomAlertView : UIView <CustomAlertBoxDelegate>
-(CustomAlertView*) initWithTitle:(NSString*)title message :(NSString*)message andButtonsText:(NSArray*)ButtonsText andCancelButtonsText:(NSString*)cancelButtonText withDelegate:(id)delegate;
-(void)show;
@end

@protocol CustomAlertViewDelegate <NSObject>

-(void)alertButtonTappedWithIndex:(int)index forView:(CustomAlertView*)view;
                                                 
@end