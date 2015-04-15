//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by John Gallagher on 1/6/14.
//  Copyright (c) 2014 John Gallagher. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) BNRHypnosisView *hypnosisView;

@end

@implementation BNRHypnosisViewController

// The UIScrollView class can have a delegate that must adopt the UIScrollViewDelegate protocol. For zooming and panning to work, the delegate must implement both viewForZoomingInScrollView: and scrollViewDidEndZooming:withView:atScale:; in addition, the maximum (maximumZoomScale) and minimum ( minimumZoomScale) zoom scale must be different.

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIView *view = self.hypnosisView;
    NSLog(@"view is %@", view);
    return view;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(CGFloat)scale
{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";

        // Create a UIImage from a file
        // This will use Hypno@2x on retina display devices
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];

        // Put that image on the tab bar item
        self.tabBarItem.image = image;
    }

    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)loadView
{
    // Create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect bigRect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame)*5.0, CGRectGetHeight(frame)*5.0);

    self.scrollView = [[UIScrollView alloc] initWithFrame:bigRect];
    self.hypnosisView = [[BNRHypnosisView alloc] initWithFrame:bigRect];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    [self.hypnosisView addSubview:textField];

    CGSize scrollViewSize = CGSizeMake(CGRectGetWidth(bigRect), CGRectGetHeight(bigRect));
    self.scrollView.contentSize = scrollViewSize;
    self.scrollView.minimumZoomScale = 0.01;
    self.scrollView.maximumZoomScale = 10.0;
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.hypnosisView];
    // Set it as *the* view of this view controller
    //self.view = self.hypnosisView;
    self.view = self.scrollView;
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];

    NSLog(@"BNRHypnosisViewController loaded its view");
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        [messageLabel sizeToFit];
        
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc]
                        initWithKeyPath:@"center.x"
                        type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc]
                        initWithKeyPath:@"center.y"
                        type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
        
        
                                                                             
    }
}

@end
