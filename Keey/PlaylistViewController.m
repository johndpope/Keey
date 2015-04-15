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
#import "PlaylistModel.h"

@interface PlaylistViewController () {
    PlaylistCollectionViewController *patternItemsCollectionCtrl;
    PlaylistModel *playlistModel;
    UIView *currentPortView;
    CALayer *recordLayer;
}

@end

@implementation PlaylistViewController

@synthesize allPatterns;
@synthesize allPatternsController;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    PlaylistPatternPortView *portView = [[PlaylistPatternPortView alloc] initWithFrame:CGRectMake(150, 100, [self window_width]-100, 500)];
    [portView setUpPorts:10];
    [portView setDelegate:self];
    [self.view addSubview:portView];
    
    [self displayRecordControl];
    
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

- (void) HandlePortHoldGesture: (UIGestureRecognizer *)sender {
    
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

    KeyBoardStepSequencer *stepSequencer = (KeyBoardStepSequencer *)[allPatterns objectAtIndex:patternBtn.tag];
    
    TimeViewPort *timeViewPort = [[TimeViewPort alloc] init];
    //timeViewPort.delegate = playlistModel;
    timeViewPort.delegate = self;
    [timeViewPort ofType:patternBtn.instrumentType ofSize:SmallSize];
    [timeViewPort setTitle:stepSequencer.instrumentButton.titleLabel.text forState:UIControlStateNormal];
    [timeViewPort setKeyBoardSequencer:stepSequencer];
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

- (void) displayRecordControl {
    
    UIButton *recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 60, 60)];
    recordBtn.layer.cornerRadius = 30;
    recordBtn.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    [recordBtn addTarget:self action:@selector(handleRecordButtontouch) forControlEvents:UIControlEventTouchUpInside];
    
    recordLayer = [CALayer layer];
    
    recordLayer.frame = CGRectMake(recordBtn.frame.size.width/2-15, recordBtn.frame.size.height/2-15, 30, 30);
    recordLayer.cornerRadius = 15.0;
    recordLayer.backgroundColor = [[UIColor colorWithRed:0.878 green:0.329 blue:0.396 alpha:1] CGColor];
    
    [recordBtn.layer addSublayer:recordLayer];
    [self.view addSubview:recordBtn];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecordButtontap:)];
    [recordBtn addGestureRecognizer:tapGest];
}

- (void) handleRecordButtontouch {
    
}

- (void) handleRecordButtontap: (UITapGestureRecognizer*) sender {
    
    static BOOL isClicked;
    POPSpringAnimation *anim;
    POPSpringAnimation *animCornerRadius;
    POPSpringAnimation *animSize;

    if (!isClicked) {
        
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        anim.toValue = (__bridge id)([[UIColor colorWithRed:0.878 green:0.329 blue:0.396 alpha:1] CGColor]);
        anim.springSpeed = 30;
        anim.springBounciness = 10;
        anim.removedOnCompletion = YES;
        
        [sender.view.layer pop_addAnimation:anim forKey:@"springAnimation"];
        
        recordLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        
        animSize = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(0.7, 0.7)];
        animSize.springSpeed = 30;
        animSize.springBounciness = 10;
        animSize.removedOnCompletion = YES;
        
        animCornerRadius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
        animCornerRadius.toValue = @5;
        animCornerRadius.springSpeed = 20;
        animCornerRadius.springBounciness = 10;
        animCornerRadius.removedOnCompletion = YES;

        
        animSize.completionBlock = ^(POPAnimation *animation, BOOL finished){
            
            [recordLayer pop_addAnimation:animCornerRadius forKey:@"springAnimation"];

        };
        
        [recordLayer pop_addAnimation:animSize forKey:@"springAnimation"];

    } else {
        
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        anim.toValue = (__bridge id)([[UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1] CGColor]);
        anim.springSpeed = 30;
        anim.springBounciness = 10;
        anim.removedOnCompletion = YES;
        
        [sender.view.layer pop_addAnimation:anim forKey:@"springAnimation"];
        
        recordLayer.backgroundColor = [[UIColor colorWithRed:0.878 green:0.329 blue:0.396 alpha:1] CGColor];
        
        animSize = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        animSize.springSpeed = 30;
        animSize.springBounciness = 10;
        animSize.removedOnCompletion = YES;
        
        animCornerRadius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
        animCornerRadius.toValue = @15;
        animCornerRadius.springSpeed = 20;
        animCornerRadius.springBounciness = 10;
        animCornerRadius.removedOnCompletion = YES;
        
        
        animSize.completionBlock = ^(POPAnimation *animation, BOOL finished){
            
            [recordLayer pop_addAnimation:animCornerRadius forKey:@"springAnimation"];
            
        };
        
        [recordLayer pop_addAnimation:animSize forKey:@"springAnimation"];
        
    }
    
    isClicked =!isClicked;
    
}

- (void) HandleTimeViewPortTouch: (TimeViewPort *)timeView {
    
    [playlistModel addToPlayingQueue: timeView];
    
}

- (void) HandleTimeViewPortDoubleTouch: (TimeViewPort *)timeView {
    [self presentViewController:timeView.keyBoardSequencer animated:YES completion:nil];
    NSLog(@"doubleTouch tag is: %d", timeView.tag);
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
