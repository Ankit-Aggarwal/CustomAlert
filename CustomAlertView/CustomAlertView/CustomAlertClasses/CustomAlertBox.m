//
//  CustomAlertView.m
//  test
//
//  Created by Ankit on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomAlertBox.h"


#define kTitleLabelColor [UIColor grayColor]
#define kMessageLabelColor [UIColor whiteColor]
#define kTitleLabelFont [UIFont boldSystemFontOfSize:18]
#define kMessageLabelFont [UIFont systemFontOfSize:15]

#define kWidthOfView 250
#define kButtonHeight 40

typedef enum 
{
    NormalButton,
    CancelButton
    
}buttonsType;

typedef enum 
{
    TitleLabel,
    MessageLabel
    
}LabelType;

@interface CustomAlertBox ()
@property (nonatomic,assign)int originY;
@property (nonatomic,assign)int originX;
@property (nonatomic,assign)int nButtons;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong )NSArray *buttons;

-(UILabel*)labelWithText:(NSString*)text andType:(LabelType)type;
-(void)buttonWithText:(NSString*)text andTag:(int)tag andType:(buttonsType)type;
@end
@implementation CustomAlertBox
@synthesize originY,originX;
@synthesize nButtons;
@synthesize messageLabel,titleLabel;
@synthesize buttons;
@synthesize delegate;

-(CustomAlertBox*) initWithTitle:(NSString*)title message :(NSString*)message andButtonsText:(NSArray*)ButtonsText andCancelButtonsText:(NSString*)cancelButtonText

{
    self = [super init];
    if (self) {
        if (cancelButtonText) {
            self.nButtons = [ButtonsText count]+1;
        }else {
            self.nButtons = [ButtonsText count];
        }
         NSLog(@"buttons are %d",nButtons);
        
        NSAssert(self.nButtons <= 7,@"Number of buttons exceeding alert view limit");
        
        self.originY = 10;
        originX = 7;
        self.titleLabel = [self labelWithText:title andType:TitleLabel];
        
        [self addSubview:self.titleLabel];
        self.messageLabel = [self labelWithText:message andType:MessageLabel];
        [self addSubview:self.messageLabel];
        
        for(NSString *buttonTitle in ButtonsText)
        {
            [self buttonWithText:buttonTitle andTag:[ButtonsText indexOfObject:buttonTitle] andType:NormalButton];
        }
       
        if (cancelButtonText) {
            [self buttonWithText:cancelButtonText andTag:(nButtons-1) andType:CancelButton];
        }
        self.frame = CGRectMake(0, 0, kWidthOfView, originY+15);
        
        self.backgroundColor = [UIColor colorWithRed:233.0/255 green:18.0/255 blue:200.0/255 alpha:0.3];
        self.layer.cornerRadius = 10;
        [self styleView];
        [self createViewAnimations];
    }
 
    return self;
}

- (void)styleView
{
    // Border
    [self.layer setBorderWidth:2.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f].CGColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 10.0f;
    
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)buttonWithText:(NSString*)text andTag:(int)tag andType:(buttonsType)buttonType
{
    UIButton *aButton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [aButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    aButton.tag = 1000+tag;
   
    if(nButtons == 2){
        // if there are only two buttons show them in one line, decrease the width of button
        
        aButton.frame = CGRectMake(originX, originY+5,  ((kWidthOfView - 23)/2), kButtonHeight);
        originX = 16 + aButton.frame.size.width;
    }else {
        aButton.frame = CGRectMake(originX, originY+5, (kWidthOfView - 14), kButtonHeight);
        originY += 45;
    }
    
     // can make the changes (font color , font size here for title
    if (buttonType == CancelButton) {
        // special changes for cancel button
         aButton.backgroundColor = [UIColor colorWithRed:144.0/255 green:123.0/255 blue:133.0/255 alpha:1];
        if (nButtons == 2) {
            originY += 45;
        }
    }else {
        // changes for other buttons
         aButton.backgroundColor = [UIColor greenColor];
    }
    aButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [aButton setTitle:text forState:UIControlStateNormal ];
    [aButton setTitle:text forState:UIControlStateHighlighted | UIControlStateSelected ];
    [aButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal ];
    [aButton setTitleColor:[UIColor whiteColor]forState:UIControlStateHighlighted ];
    aButton.titleLabel.font = [UIFont systemFontOfSize:16];
    aButton.layer.cornerRadius = 5;
    
    [self addSubview:aButton];
}
-(UILabel*)labelWithText:(NSString*)text andType:(LabelType)type 
{
    CGSize maximumLabelSize = CGSizeMake( (kWidthOfView - 14),9999);
    UILabel *lbl;
    
    if (type == TitleLabel) {
        // set the custom font , and other text properties
        CGSize expectedLabelSize = [text sizeWithFont:kTitleLabelFont
                                    constrainedToSize:maximumLabelSize 
                                        lineBreakMode:UILineBreakModeCharacterWrap]; 
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, originY,  (kWidthOfView - 14), expectedLabelSize.height)];
        lbl.font = kTitleLabelFont;
        originY += (expectedLabelSize.height+ 10); 
        lbl.textColor = kTitleLabelColor;
        
    }else if (type == MessageLabel) {
        
        CGSize expectedLabelSize = [text sizeWithFont:kMessageLabelFont
                                    constrainedToSize:maximumLabelSize 
                                        lineBreakMode:UILineBreakModeCharacterWrap]; 
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, originY,  (kWidthOfView - 14), expectedLabelSize.height)];
        lbl.font = kMessageLabelFont;
        originY += (expectedLabelSize.height+ 10); 
        lbl.textColor = kMessageLabelColor;
    }
    
    lbl.numberOfLines = 0;
    lbl.text = text;
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.backgroundColor = [UIColor clearColor];
    return lbl;
}
-(void)buttonTapped:(UIButton*)aButton
{
    NSLog(@"button tapped with tag %d",aButton.tag);
    [self.delegate buttonTappedWithindex:(aButton.tag-1000)];
}
- (void)createViewAnimations
{
    // Pop in animation
    CALayer *viewLayer = self.layer;
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    popInAnimation.duration = 0.5f;
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.1],
                             [NSNumber numberWithFloat:0.9],
                             [NSNumber numberWithFloat:1.0],
                             nil];
    
    popInAnimation.timingFunctions = [NSArray arrayWithObjects:
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      nil];
    
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];
}
@end
