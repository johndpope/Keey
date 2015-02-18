//
//  MainViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "MainViewController.h"
#import "Drums.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.204 green:0.22 blue:0.22 alpha:2];
    
    _segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Pattern", @"Playlist", nil]];
    _segControl.frame = CGRectMake(400, 50, 200, 50);
    _segControl.selectedSegmentIndex = 0;
    
    [_segControl addTarget:self
                    action:@selector(HandleSegCtrlClick:)
          forControlEvents:UIControlEventValueChanged];
    
    //[self.view addSubview:_segControl];
    
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

- (void) HandleSegCtrlClick: (id) sender {
    
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self displayContentController:_patternViewCTRL];
            [self hideContentController:_playlistViewCTRL];
            break;
        case 1:
            [self hideContentController:_patternViewCTRL];
            [self displayContentController:_playlistViewCTRL];
            break;
        default:
            break;
    }
}

- (void) displayContentController: (UIViewController*) content;
{
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, 120, [self window_width], [self window_height]);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
}

- (void) hideContentController: (UIViewController*) content
{
    [content willMoveToParentViewController:nil];  // 1
    [content.view removeFromSuperview];            // 2
    [content removeFromParentViewController];      // 3
}

- (CGFloat) window_height   {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

- (CGFloat) window_width   {
    return [UIScreen mainScreen].applicationFrame.size.width;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
