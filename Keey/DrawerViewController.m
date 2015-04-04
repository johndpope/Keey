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
#import <pop/POP.h>

@interface DrawerViewController ()

@end

@implementation DrawerViewController
@synthesize delegate; //synthesise  MyClassDelegate delegate

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self window_width], [self window_height])];
    [self.view addSubview:_backgroundView];
    
    _panelView = [[PanelView alloc] initWithFrame:CGRectMake(0, [self window_height], [self window_width], 600)];
    [_panelView displayViewWithTitle:@"Add an Instrument"];
    [self.view addSubview:_panelView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [pan setDelegate:self];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [_panelView.panelHeader addGestureRecognizer:pan];
    
    [_panelView.panelHeaderCloseBtn addTarget:self action:@selector(OverLayDidTap) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OverLayDidTap)];
    tapRecog.numberOfTapsRequired = 1;
    [_backgroundView addGestureRecognizer:tapRecog];
    
}

- (void) animateDrawerIn {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    //anim.fromValue = [NSNumber numberWithFloat:[self window_height]+370];
    anim.toValue = [NSNumber numberWithFloat:[self window_height]-(_panelView.frame.size.height/2 - 200)];
    anim.velocity = [NSNumber numberWithFloat:50];
    anim.springSpeed = 30;
    anim.springBounciness = 10;
    anim.removedOnCompletion = YES;
    
    [_panelView.layer pop_addAnimation:anim forKey:@"springAnimation"];

}

- (void) animateDrawerOut: (completionBlock) compBlock {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = [NSNumber numberWithFloat:[self window_height]+370];
    anim.velocity = [NSNumber numberWithFloat:50];
    anim.springSpeed = 30;
    anim.springBounciness = 10;
    anim.removedOnCompletion = YES;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
    };
    compBlock(YES);
    [_panelView.layer pop_addAnimation:anim forKey:@"springAnimation"];
    
}

- (void) OverLayDidTap {
    //this will call the method implemented in your other class
    [self.delegate closeDrawerController:self];
}

- (void) displayDrawerElements: ( NSArray *) elements {

    [_panelView displayContent: elements];
    
}

- (void) pan:(UIPanGestureRecognizer *)aPan{
    
    CGPoint currentPoint = [aPan locationInView:self.view];
    
    if (currentPoint.y > 200) {
        
        [UIView animateWithDuration:0.01f
                         animations:^{
                             
                             CGRect oldFrame = _panelView.frame;
                             oldFrame.origin.y = currentPoint.y;
                             _panelView.frame = oldFrame;
                             
                         }];

    }
    
    if (aPan.state == UIGestureRecognizerStateEnded) {
        
        if (currentPoint.y < [self window_height]/1.5) {
            
            [self animateDrawerIn];
            
        } else {
            
            [self OverLayDidTap];
            
        }
    }
    
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
