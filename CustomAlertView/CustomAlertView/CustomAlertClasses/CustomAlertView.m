//
//  CustomAlertView.m
//  test
//
//  Created by Ankit on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomAlertView.h"
@interface CustomAlertView()
@property(nonatomic,assign) id <CustomAlertViewDelegate> delegate;
@property (nonatomic,strong)CustomAlertBox *alertBox;
@end

@implementation CustomAlertView
@synthesize alertBox;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(CustomAlertView*) initWithTitle:(NSString*)title message :(NSString*)message andButtonsText:(NSArray*)ButtonsText andCancelButtonsText:(NSString*)cancelButtonText withDelegate:(id)delegateController
{
    self = [super init];
    if (self) {
        self.delegate = delegateController;
        
        CGRect frame = [UIScreen mainScreen].applicationFrame ;
        self.frame = frame;
        
        self.alertBox = [[CustomAlertBox alloc]initWithTitle:title message:message andButtonsText:ButtonsText andCancelButtonsText:cancelButtonText];
        self.alertBox.delegate = self; 
        self.alertBox.center = CGPointMake(self.center.x, self.center.y - [UIScreen mainScreen].applicationFrame.origin.y ) ;
        [self addSubview:self.alertBox];
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    }
   
    return self;
}
-(void)show
{
    self.alpha =  0;
    [[[[UIApplication sharedApplication]windows]lastObject]addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^(void)
     {
         self.alpha =  1;
         
     }completion:^(BOOL finished) {
     }];
    
}
-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^(void)
     {
         self.alpha =  0;
         
     }completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
}

#pragma mark - <CustomAlertBoxDelegate method

-(void)buttonTappedWithindex:(int)index
{
    [self.delegate alertButtonTappedWithIndex:index forView:self];
    [self hide];
}
@end
