//
//  PlaylistViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "PlaylistViewController.h"
#import "TLSpringFlowLayout.h"
#import "TimeViewPort.h"
#import "PlaylistModel.h"

@interface PlaylistViewController () {
    PlaylistCollectionViewController *patternItemsCollectionCtrl;
    PlaylistModel *playlistModel;
    UIView *currentPortView;
}

@end

@implementation PlaylistViewController

@synthesize allPatterns;
@synthesize allPatternsController;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    PlaylistPatternPortView *portView = [[PlaylistPatternPortView alloc] initWithFrame:CGRectMake(150, 50, [self window_width]-100, 500)];
    [portView setUpPorts:10];
    [portView setDelegate:self];
    [self.view addSubview:portView];
    
    TLSpringFlowLayout *aFlowLayout = [[TLSpringFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    patternItemsCollectionCtrl = [[PlaylistCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    patternItemsCollectionCtrl.patterns = [[NSMutableArray alloc] init];
    [patternItemsCollectionCtrl setPatterns:allPatterns];
    [patternItemsCollectionCtrl setDelegate:self];
    
    currentPortView = [[TimeViewPort alloc] init];
    
    playlistModel = [[PlaylistModel alloc] init];
    
    [playlistModel setUpTimerWithDelay:2];
    
}


- (void) handleUpdate{

}

- (void) HandlePortHoldGesture: (UILongPressGestureRecognizer *)sender {
    
    [patternItemsCollectionCtrl setPatterns:allPatterns];
    [patternItemsCollectionCtrl.collectionView reloadData];
    [self displayContentController:patternItemsCollectionCtrl];
    currentPortView = sender.view;
    
}

- (void) HandleCollectionViewBodyTouch {
    
    [self hideContentController:patternItemsCollectionCtrl];
    
}

- (void) HandlePatternTouch: (InstrumentButton *) sender {
    
    //[playlistModel HandlePatternPortInsert:[allPatterns objectAtIndex:sender.tag]];
    [self displayTimeViewForPort:sender];
    
}

- (void) displayTimeViewForPort: (InstrumentButton *) patternBtn {

    TimeViewPort *timeViewPort = [[TimeViewPort alloc] init];
    [timeViewPort ofType:patternBtn.instrumentType ofSize:SmallSize];
    [timeViewPort setTitle:@"" forState:UIControlStateNormal];
    [timeViewPort setKeyBoardSequencer:(KeyBoardStepSequencer *)[allPatterns objectAtIndex:patternBtn.tag]];
    [playlistModel.queuedPatterns addObject:timeViewPort];
    [currentPortView addSubview:timeViewPort];
    
}

- (void) displayContentController: (UICollectionViewController *) content {
    
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, -120, [self window_width], [self window_height]);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
    
}

- (void) hideContentController: (UIViewController*) content {
    [content willMoveToParentViewController:nil];  // 1
    [content.view removeFromSuperview];            // 2
    [content removeFromParentViewController];      // 3
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

@end
