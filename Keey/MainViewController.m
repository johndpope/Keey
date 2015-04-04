//
//  MainViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "MainViewController.h"
#import "Drums.h"

@interface MainViewController () {
    UIView *cusSegControl;
    UIButton *patternButton;
    UIButton *playlistButton;
}

@end

@implementation MainViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    
    _segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Pattern", @"Playlist", nil]];
    _segControl.frame = CGRectMake(400, 50, 200, 50);
    _segControl.selectedSegmentIndex = 0;
    
    [_segControl addTarget:self
                    action:@selector(HandleSegCtrlClick:)
          forControlEvents:UIControlEventValueChanged];
    
    //[self.view addSubview:_segControl];
    
    [self displayCustomSegmentedControl];

    _patternViewCTRL = [[PatternViewController alloc] init];
    _playlistViewCTRL = [[PlaylistViewController alloc] init];
    
    [self displayContentController:_patternViewCTRL];
    
    /*
    
    _patternView = [[PatternView alloc] initWithFrame:CGRectMake(0, 150, [self window_width], [self window_height]-100)];
    [_patternView layoutViews];
    [self.view addSubview:_patternView];
    
    _playlistView = [[PlaylistView alloc] initWithFrame:CGRectMake(0, 150, [self window_width], [self window_height]-100)];
    [_playlistView layoutViews];
    [_playlistView setHidden:YES];
    [self.view addSubview:_playlistView];
     */
    
}

- (void) displayContentController: (UIViewController*) content {
    
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, 120, [self window_width], [self window_height]);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
    
}

- (void) hideContentController: (UIViewController*) content {
    [content willMoveToParentViewController:nil];  // 1
    [content.view removeFromSuperview];            // 2
    [content removeFromParentViewController];      // 3
}

- (void) displayCustomSegmentedControl {
    
    cusSegControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 55)];
    cusSegControl.center = CGPointMake([self window_width]/2, 70.0);
    cusSegControl.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    cusSegControl.layer.cornerRadius = 27.5;
    [self.view addSubview:cusSegControl];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(-5, -3, 140, 60)];
    _selectedView.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
    _selectedView.layer.cornerRadius = 30;
    [cusSegControl addSubview:_selectedView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:) ];
    [pan setDelegate:self];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [_selectedView addGestureRecognizer:pan];
    
    patternButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 135, 45)];
    patternButton.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:16];
    patternButton.userInteractionEnabled = NO;
    [patternButton setAlpha:0.98];
    [patternButton setTitle:@"pattern" forState:UIControlStateNormal];
    [patternButton setTag:0];
    [cusSegControl addSubview:patternButton];
    
    playlistButton = [[UIButton alloc] initWithFrame:CGRectMake(135, 5, 135, 45)];
    playlistButton.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:16];
    playlistButton.userInteractionEnabled = NO;
    [playlistButton setAlpha:0.98];
    [playlistButton setTitle:@"playlist" forState:UIControlStateNormal];
    [playlistButton setTitleColor:[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] forState:UIControlStateNormal];
    [playlistButton setTag:1];
    [cusSegControl addSubview:playlistButton];
}

- (void) HandleSegCtrlClick: (id) sender {
    
    switch ([sender tag]) {
        case 0:
            
            [self moveSelected:0];
            [self displayContentController:_patternViewCTRL];
            [self hideContentController:_playlistViewCTRL];
            break;
        case 1:
            [self moveSelected:1];
            [self hideContentController:_patternViewCTRL];
            [self displayContentController:_playlistViewCTRL];
            [self updatePlaylist];
            break;
        default:
            break;
    }
}

- (void) updatePlaylist {
    
    //NSLog(@"%@ thats how much", [_patternViewCTRL getAllPatternsButtons]);
    [_playlistViewCTRL setAllPatterns: [_patternViewCTRL getAllCurrentPatternControllers]];
    [_playlistViewCTRL handleUpdate];
    
}

- (void) moveSelected: (int) selectedIndex{
    
    if (selectedIndex == 0) {

        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];

        anim.toValue = @68;
        anim.velocity = @40;
        anim.springBounciness = 20.f;
        anim.springSpeed = 30;
        
        [_selectedView.layer pop_addAnimation:anim forKey:@"springAnimation"];
        
        [patternButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [playlistButton setTitleColor:[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] forState:UIControlStateNormal];
        
    } else {
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];

        anim.toValue = @202;
        anim.velocity = @40;
        anim.springBounciness = 20.f;
        anim.springSpeed = 30;
        
        [_selectedView.layer pop_addAnimation:anim forKey:@"springAnimation"];
        
        [playlistButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [patternButton setTitleColor:[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] forState:UIControlStateNormal];
        
    }
    
}

- (void) pan:(UIPanGestureRecognizer *)aPan{
    
    //CGPoint locationOfPan = [aPan locationInView:seqcollectionview];
    
    float divisor;
    float alpha;
    
    UIView *segSelectedView = aPan.view;
    
    CGPoint currentPoint = [aPan locationInView:cusSegControl];
    
    
    //NSLog(@"x is: %f",currentPoint.x);
    
    if (currentPoint.x > 30 && currentPoint.x < 250 ) {
        
        [UIView animateWithDuration:0.01f
                         animations:^{
                             
                             CGRect oldFrame = segSelectedView.frame;
                             
                             segSelectedView.frame = CGRectMake(currentPoint.x-70, -3, oldFrame.size.width, oldFrame.size.height);
                             
                         }];
        
        if (segSelectedView.frame.origin.x > 0) {
            
            if (segSelectedView.frame.origin.x < cusSegControl.frame.size.width/2) {
                
                divisor = cusSegControl.frame.size.width/2;
                alpha = (segSelectedView.frame.origin.x/divisor) - 1;
                
                [patternButton setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:fabsf(alpha)] forState:UIControlStateNormal];
                [playlistButton setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:(segSelectedView.frame.origin.x/divisor)] forState:UIControlStateNormal];
                
            }
            
        }
    }
    
    if (aPan.state == UIGestureRecognizerStateEnded) {
        
        if (currentPoint.x < cusSegControl.frame.size.width/2) {
            [self HandleSegCtrlClick:patternButton];
        } else {
            [self HandleSegCtrlClick:playlistButton];
        }
        
    }
    
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
