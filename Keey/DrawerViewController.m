//
//  DrawerViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 14/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "DrawerViewController.h"

@interface DrawerViewController ()

@end

@implementation DrawerViewController
@synthesize delegate; //synthesise  MyClassDelegate delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _panelView = [[PanelView alloc] initWithFrame:CGRectMake(0, [self window_height], [self window_width], 400)];
    [_panelView displayViewWithTitle:@"Add an Instrument"];
    [self.view addSubview:_panelView];
    
    [self animateDrawerIn];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OverLayDidTap:)];
    
    tapRecog.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tapRecog];
    
}

- (void) animateDrawerIn {
    [UIView animateKeyframesWithDuration:0.4
                                   delay:0.4
                                 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  CGRect originalFrame = _panelView.frame;
                                  originalFrame.origin.y = 250;
                                  _panelView.frame = originalFrame;
                              }
                              completion:^(BOOL finished) {
                                  
                              }];
}

- (void) OverLayDidTap:(UITapGestureRecognizer*)sender {
    //this will call the method implemented in your other class
    [self.delegate DrawerViewControllerDelegateMethod:self];
}

- (void) displayDrawerElements: ( NSArray *) elements {

    [_panelView displayContent: elements];
    
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
