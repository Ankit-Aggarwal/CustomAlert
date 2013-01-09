//
//  CustomAlertView.h
//  test
//
//  Created by Ankit on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertBoxDelegate <NSObject>

-(void)buttonTappedWithindex:(int)index;

@end

@interface CustomAlertBox : UIView

@property (nonatomic,assign )id<CustomAlertBoxDelegate> delegate;

-(CustomAlertBox*) initWithTitle:(NSString*)title message :(NSString*)message andButtonsText:(NSArray*)ButtonsText andCancelButtonsText:(NSString*)cancelButtonText;

@end
