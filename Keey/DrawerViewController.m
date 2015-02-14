//
//  DrawerViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 14/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "DrawerViewController.h"

@interface DrawerViewController ()

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    _panelView = [[PanelView alloc] initWithFrame:CGRectMake(0, [self window_height], [self window_width], 350)];
    [_panelView displayViewWithTitle:@"Add an Instrument"];
    [self.view addSubview:_panelView];
    
    [self animateDrawerIn];
    
    
    
}

- (void) animateDrawerIn {
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0.5
                                 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  CGRect originalFrame = _panelView.frame;
                                  originalFrame.origin.y = 300;
                                  _panelView.frame = originalFrame;
                              }
                              completion:^(BOOL finished) {
                                  // block fires when animaiton has finished
                              }];
}

- (CGFloat) window_height {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

- (CGFloat) window_width {
    return [UIScreen mainScreen].applicationFrame.size.width;
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
