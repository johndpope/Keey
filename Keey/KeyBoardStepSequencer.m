//
//  KeyBoardStepSequencer.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "KeyBoardStepSequencer.h"
#import "InstrumentalHeaderView.h"
#import "MusicSequencerModel.h"
#import "KeyboardViewModel.h"
#import "MarkerView.h"
#import "BeatBarHeaderView.h"
#import "PianoRollConfig.h"
#import "StepViewCell.h"
#import "StepState.h"


@interface KeyBoardStepSequencer () {
    
    UICollectionView *seqcollectionview;
    InstrumentalHeaderView *keyboardView;
    KeyboardViewModel *keyboardViewModel;
    UIView *sequencerContainerView;
    UIView *custNavBar;
    NSIndexPath *currentHighlightedIndexPath;
    int currentHighlightedIndexPathLength;
    MarkerView *marker;
    CustomModal *customModalMenu;
    BeatBarHeaderView *barheaderView;
    PianoRollConfig *config;
    StepViewCell *customCell;

}

@end

@implementation KeyBoardStepSequencer

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidAppear:(BOOL)animated {
    
    marker = [[MarkerView alloc] initWithFrame:CGRectMake(0, 0, 1, seqcollectionview.frame.size.height)];
    [marker displayMarkerLine];
    [seqcollectionview addSubview:marker];
    //[marker startAnimation:4 toDestination:seqcollectionview.frame.size.width];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    
    [self setUpNavBar];
    
    config = [[PianoRollConfig alloc] init];
    config.currentOctave = OctaveTypeMid;
    config.currentMeasure = 1;
    
    keyboardViewModel = [[KeyboardViewModel alloc] init];
    [keyboardViewModel createStepStatesWithSections:32 withKeyNoteCount:12];
    [keyboardViewModel setupKeys:16];
    
    [self setUpSequencerView];
    
    [self setUpModalView];
    
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 32;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20; // This is the minimum inter item spacing, can be more
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StepViewCell *stepCell;
    stepCell = (StepViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"StepViewCell" forIndexPath:indexPath];
    
    stepCell.layer.borderColor = [[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] CGColor];
    stepCell.layer.borderWidth = 2;
    stepCell.layer.cornerRadius = stepCell.frame.size.width/2;
    
    if ([indexPath row]%8 > 3){
        //EVERY 2nd bar
       
    }
    
    stepCell.backgroundColor = [UIColor clearColor];
    
    if ([keyboardViewModel isStateSelectedAt:[indexPath row] positionInPianoRoll:[indexPath section]]) {
        
        stepCell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
        stepCell.layer.borderColor = [[UIColor clearColor] CGColor];
        
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [stepCell addGestureRecognizer:longPress];
    
    return stepCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(35, 35);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(11, 0, 11, 22);
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [seqcollectionview cellForItemAtIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
    cell.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [seqcollectionview reloadData];
    [self addStepToSequencer:indexPath withLength:1];
    
}

- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [seqcollectionview cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderColor = [[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] CGColor];
    
    [self addStepToSequencer:indexPath withLength:0];
    
}

- (void) setUpSequencerView {
    
    sequencerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, custNavBar.frame.size.height, [self window_width]*2, [self window_height]- custNavBar.frame.size.height)];
    sequencerContainerView.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    [self.view addSubview:sequencerContainerView];
    
    UICollectionViewFlowLayout *sequencerLayout = [[UICollectionViewFlowLayout alloc]init];
    [sequencerLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [sequencerLayout setMinimumLineSpacing:0];
    
    seqcollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(120, 0, (sequencerContainerView.frame.size.width/2) -120, sequencerContainerView.frame.size.height) collectionViewLayout:sequencerLayout];
    [seqcollectionview registerClass:[StepViewCell class] forCellWithReuseIdentifier:@"StepViewCell"];
    seqcollectionview.backgroundColor = [UIColor clearColor];
    [seqcollectionview setDataSource:self];
    [seqcollectionview setDelegate:self];
    
    seqcollectionview.allowsMultipleSelection = YES;
    
    [sequencerContainerView addSubview:seqcollectionview];
    
    keyboardView = [[InstrumentalHeaderView alloc] initWithFrame:CGRectMake(0, 0, 100, sequencerContainerView.frame.size.height)];
    [keyboardView setUpHeaders:16 withType:HeaderTypeKeyboard];
    [sequencerContainerView addSubview:keyboardView];
    
    barheaderView = [[BeatBarHeaderView alloc] init];
    [barheaderView setUpViewWithCount:8 withSpacing:((35*4) + (20*3)+6)+23];
    [seqcollectionview addSubview:barheaderView];
}

- (void) setUpNavBar {
    
    custNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self window_width], 75)];
    custNavBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:custNavBar];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(custNavBar.frame.size.width-70, 25, 30, 30)];
    [closeButton addTarget:self action:@selector(dismissviewctrl) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [custNavBar addSubview:closeButton];
    
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(custNavBar.frame.size.width-150, 25, 28, 28)];
    //[settingsButton addTarget:self action:@selector(dismissviewctrl) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    //[custNavBar addSubview:settingsButton];
    
    UIButton *octaveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    octaveButton.backgroundColor = [UIColor colorWithRed:0.141 green:0.184 blue:0.204 alpha:1];
    [octaveButton addTarget:self action:@selector(handleMenuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //[octaveButton setBackgroundImage:[UIImage imageNamed:@"octave.png"] forState:UIControlStateNormal];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 35, 35)];
    imageView.image = [UIImage imageNamed:@"octave.png"];
    [octaveButton addSubview:imageView];
    
    [custNavBar addSubview:octaveButton];
    
}

- (void) handleMenuButtonClick {
    
    if ([customModalMenu isHidden]) {
        
        [customModalMenu setHidden:NO];
        
    } else {
        
        [customModalMenu setHidden:YES];
        
    }
    
}

- (void) setUpModalView {
    
    customModalMenu = [[CustomModal alloc] initWithFrame:CGRectMake(0, 0, [self window_width], [self window_height])];
    [customModalMenu setupView];
    [customModalMenu setHidden:YES];
    [self.view addSubview:customModalMenu];
    
    [customModalMenu setDelegate:self];
    
}

- (void) CustomModalViewDelegateMethod:(CustomModal *)sender {
    [self handleMenuButtonClick];
}

- (void) handleLongPress: (UIGestureRecognizer *)longPress {

    NSIndexPath *indexPath;

    if (longPress.state==UIGestureRecognizerStateBegan) {
        
        CGPoint pressPoint = [longPress locationInView:seqcollectionview];
        indexPath = [seqcollectionview indexPathForItemAtPoint:pressPoint];
        
        currentHighlightedIndexPath = indexPath;
        
        [self drawChord:currentHighlightedIndexPath];

    }

}

- (void) drawChord: (NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [seqcollectionview cellForItemAtIndexPath:indexPath];

    UIView *chord = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 92, 34)];
    chord.layer.cornerRadius = 17;
    chord.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
    
    [seqcollectionview addSubview:chord];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:) ];
    [pan setDelegate:self];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [chord addGestureRecognizer:pan];
    
    //[self addStepToSequencer:currentHighlightedIndexPath withLength:2];

}

- (void) pan:(UIPanGestureRecognizer *)aPan{
    
    //CGPoint locationOfPan = [aPan locationInView:seqcollectionview];
    UIView *chord = aPan.view;
    
    currentHighlightedIndexPathLength = [[NSString stringWithFormat:@"%.1f", chord.frame.size.width/50]floatValue];
    
    CGPoint currentPoint = [aPan locationInView:chord];

    
    if (currentPoint.x > 0) {
        
        currentHighlightedIndexPath = [seqcollectionview indexPathForItemAtPoint:chord.frame.origin];

    [UIView animateWithDuration:0.01f
                     animations:^{
                         CGRect oldFrame = chord.frame;
                         
                             chord.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.height+currentPoint.x, oldFrame.size.height);
                         
                     }];
    }
    
    if (aPan.state == UIGestureRecognizerStateEnded) {
        
        int numberOfSteps = [[NSString stringWithFormat:@"%.1f", chord.frame.size.width/50]floatValue];
        
        [self summariseBarLength:chord:numberOfSteps];
    }
    
}

- (void) summariseBarLength: (UIView *)chordView :(int)chordLength {
    //NSLog(@"%d", chordLength);
    CGRect oldFrame = chordView.frame;
    
    if (chordLength > 1) {
        
        oldFrame.size.width = 22*(chordLength-1) + 35*chordLength;
        chordView.frame = oldFrame;

    } else if (chordLength == 1) {
        
        oldFrame.size.width = 92;
        chordView.frame = oldFrame;
        
    } else {
        //[keyboardViewModel setLengthForStepAtPosition:[currentHighlightedIndexPath section] withStepLength:0 forNote:[currentHighlightedIndexPath row]];
        [chordView removeFromSuperview];
        
    }
    
    [self addStepToSequencer:currentHighlightedIndexPath withLength:chordLength];

    
}

- (void) addStepToSequencer: (NSIndexPath *)indexPath withLength: (int) length {
    
    [keyboardViewModel updateStepSeqForPosition:[indexPath section] withlength:length withKeyNote:[indexPath row]];
    
}

- (void) dismissviewctrl {
    //[seqcollectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:30] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

@end
