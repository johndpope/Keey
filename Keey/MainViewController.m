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

@interface MainViewController ()

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
    
    UIView *cusSegControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 55)];
    cusSegControl.center = CGPointMake([self window_width]/2, 70.0);
    cusSegControl.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    cusSegControl.layer.cornerRadius = 27.5;
    [self.view addSubview:cusSegControl];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(-5, -3, 140, 60)];
    _selectedView.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
    _selectedView.layer.cornerRadius = 30;
    [cusSegControl addSubview:_selectedView];
    
    UIButton *first = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 135, 45)];
    [first addTarget:self action:@selector(HandleSegCtrlClick:) forControlEvents:UIControlEventTouchUpInside];
    first.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:14];
    [first setTitle:@"pattern" forState:UIControlStateNormal];
    [first setTag:0];
    [cusSegControl addSubview:first];
    
    UIButton *second = [[UIButton alloc] initWithFrame:CGRectMake(135, 5, 135, 45)];
    [second addTarget:self action:@selector(HandleSegCtrlClick:) forControlEvents:UIControlEventTouchUpInside];
    second.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:14];
    [second setTitle:@"playlist" forState:UIControlStateNormal];
    [second setTag:1];
    [cusSegControl addSubview:second];
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

        
    } else {
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];

        anim.toValue = @202;
        anim.velocity = @40;
        anim.springBounciness = 20.f;
        anim.springSpeed = 30;
        
        [_selectedView.layer pop_addAnimation:anim forKey:@"springAnimation"];
        
        
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
