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
#import <pop/POP.h>


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
    
    int numberofSections;
    
    UIButton *firstBarControlBtn;
    UIButton *secondBarControlBtn;
    
    UIView *currentBarIndicatorViwContainer;
    
    BOOL isfirstTimeAppearing;

}

@end

@implementation KeyBoardStepSequencer

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidAppear:(BOOL)animated {
    
    if (!isfirstTimeAppearing) {
        
    marker = [[MarkerView alloc] initWithFrame:CGRectMake(0, 0, 1, seqcollectionview.frame.size.height)];
    [marker displayMarkerLine];
    [seqcollectionview addSubview:marker];
    [marker startAnimation:2 toDestination:seqcollectionview.frame.size.width];
    
    keyboardViewModel = [[KeyboardViewModel alloc] init];
    [keyboardViewModel createStepStatesWithSections:numberofSections withKeyNoteCount:12];
    [keyboardViewModel setupKeys:16];
        
        isfirstTimeAppearing = true;
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    
    [self setUpNavBar];
    
    config = [[PianoRollConfig alloc] init];
    config.currentOctave = OctaveTypeMid;
    config.currentMeasure = 1;
    
    numberofSections = 16;
    
    [self setUpSequencerView];
    
    [self setUpModalView];
    
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return numberofSections;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20; // This is the minimum inter item spacing, can be more
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //StepViewCell *stepCell;
    //stepCell = (StepViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"StepViewCell" forIndexPath:indexPath];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    
    cell.layer.borderColor = [[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] CGColor];
    cell.layer.borderWidth = 2;
    cell.layer.cornerRadius = cell.frame.size.width/2;
    
    if ([indexPath row]%8 > 3) {
        
        //EVERY 2nd bar
       
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    if ([keyboardViewModel isStateSelectedAt:[indexPath row] positionInPianoRoll:[indexPath section]]) {
        
        cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
        cell.layer.borderColor = [[UIColor clearColor] CGColor];
        
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [cell addGestureRecognizer:longPress];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(35, 35);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(11, 0, 11, 22);
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([keyboardViewModel isStateSelectedAt:[indexPath row] positionInPianoRoll:[indexPath section]]) {
        
        [self addStepToSequencer:indexPath withLength:0];

    } else {
        
        [self addStepToSequencer:indexPath withLength:1];

    }
    
    [seqcollectionview reloadData];

}

- (void) setUpSequencerView {
    
    sequencerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, custNavBar.frame.size.height, [self window_width]*2, [self window_height]- custNavBar.frame.size.height)];
    sequencerContainerView.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    [self.view addSubview:sequencerContainerView];
    
    UICollectionViewFlowLayout *sequencerLayout = [[UICollectionViewFlowLayout alloc]init];
    [sequencerLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [sequencerLayout setMinimumLineSpacing:0];
    
    seqcollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(120, 0, (sequencerContainerView.frame.size.width/2) -120, sequencerContainerView.frame.size.height) collectionViewLayout:sequencerLayout];
    //[seqcollectionview registerClass:[StepViewCell class] forCellWithReuseIdentifier:@"StepViewCell"];
    [seqcollectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    seqcollectionview.backgroundColor = [UIColor clearColor];
    [seqcollectionview setDataSource:self];
    [seqcollectionview setDelegate:self];
    
    seqcollectionview.allowsMultipleSelection = YES;
    seqcollectionview.scrollEnabled = NO;
    
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
    
    currentBarIndicatorViwContainer = [[UIView alloc] initWithFrame:CGRectMake([self window_width]/2-50, 30, 100, 30)];
    currentBarIndicatorViwContainer.hidden = YES;
    [custNavBar addSubview:currentBarIndicatorViwContainer];
    
    firstBarControlBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    [firstBarControlBtn addTarget:self action:@selector(handleBarSwitch:) forControlEvents:UIControlEventTouchUpInside];
    firstBarControlBtn.backgroundColor = [UIColor whiteColor];
    firstBarControlBtn.layer.cornerRadius = 10;
    firstBarControlBtn.tag = 1;
    [currentBarIndicatorViwContainer addSubview:firstBarControlBtn];
    
    secondBarControlBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 2.5, 15, 15)];
    [secondBarControlBtn addTarget:self action:@selector(handleBarSwitch:) forControlEvents:UIControlEventTouchUpInside];
    secondBarControlBtn.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    secondBarControlBtn.layer.cornerRadius = 7.5;
    secondBarControlBtn.tag = 2;
    [currentBarIndicatorViwContainer addSubview:secondBarControlBtn];
    
    [custNavBar addSubview:octaveButton];
    
}

- (void) handleBarSwitch: (UIButton *)sender {
    
    switch (sender.tag) {
            
        case 1:
            [seqcollectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            break;
            
        case 2:
            NSLog(@"hello");
            [seqcollectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:16] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            
            break;
            
        default:
            break;
    }
    
    [self setCurrentBarIndicatorStyle:sender.tag];
    
}

- (void) setCurrentBarIndicatorStyle: (NSUInteger) index {
    
    CGRect oldFrame;
    
    switch (index) {
            
        case 1:
            
            oldFrame = firstBarControlBtn.frame;
            oldFrame.origin.y = 0;
            oldFrame.size = CGSizeMake(20, 20);
            firstBarControlBtn.frame = oldFrame;
            firstBarControlBtn.backgroundColor = [UIColor whiteColor];
            firstBarControlBtn.layer.cornerRadius = 10;
            
            oldFrame = secondBarControlBtn.frame;
            oldFrame.origin.y = 2.5;
            oldFrame.size = CGSizeMake(15, 15);
            secondBarControlBtn.frame = oldFrame;
            secondBarControlBtn.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
            secondBarControlBtn.layer.cornerRadius = 7.5;
            
            break;
            
        case 2:
            
            oldFrame = firstBarControlBtn.frame;
            oldFrame.origin.y = 2.5;
            oldFrame.size = CGSizeMake(15, 15);
            firstBarControlBtn.frame = oldFrame;
            firstBarControlBtn.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
            firstBarControlBtn.layer.cornerRadius = 7.5;
            
            oldFrame = secondBarControlBtn.frame;
            oldFrame.origin.y = 0;
            oldFrame.size = CGSizeMake(20, 20);
            secondBarControlBtn.frame = oldFrame;
            secondBarControlBtn.backgroundColor = [UIColor whiteColor];
            secondBarControlBtn.layer.cornerRadius = 10;
            
            break;
            
        default:
            break;
    }
}
- (void) handleMenuButtonClick {
    
    if ([customModalMenu isHidden]) {
        
        [customModalMenu setHidden:NO];

        POPSpringAnimation *animframe = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        
        animframe.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
        animframe.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        animframe.springSpeed = 40;
        animframe.springBounciness = 5;
        animframe.removedOnCompletion = YES;
        [customModalMenu.layer pop_addAnimation:animframe forKey:@"springAnimation"];
        
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

- (void) CustomModalHandleOverlayTap:(CustomModal *)sender {
    [self handleMenuButtonClick];
}

- (void) CustomModalHandleBarChange: (int) bars {
    
    
    if (bars == 2) {
        
        // 32 beats 2bars
        numberofSections = 32;
        [keyboardViewModel handleBarChangewithBars:2];
        [seqcollectionview reloadData];

        [secondBarControlBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        currentBarIndicatorViwContainer.hidden = NO;
        
    } else {
        
        // 16 beats 1bars
        
        numberofSections = 16;
        [keyboardViewModel handleBarChangewithBars:1];
        [seqcollectionview reloadData];
        
        [firstBarControlBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        currentBarIndicatorViwContainer.hidden = YES;
        
    }

    
}

- (void) CustomModalHandleOctaveChange:(OctaveType)octave {
    
    switch (octave) {
            
        case OctaveTypeHigh:
            [keyboardViewModel handleOctaveChange:octave];
            break;
            
        case OctaveTypeMid:
            [keyboardViewModel handleOctaveChange:octave];
            break;
            
        case OctaveTypeLow:
            [keyboardViewModel handleOctaveChange:octave];
            break;
            
        default:
            break;
    }
}

- (void) CustomModalSwitchPreset: (NSUInteger) presetNumber {
    [keyboardViewModel handleSwitchPreset:presetNumber];
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

    UIButton *chord = [[UIButton alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 92, 34)];
    chord.layer.cornerRadius = 17;
    chord.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
    
    [seqcollectionview addSubview:chord];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:) ];
    [pan setDelegate:self];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [chord addGestureRecognizer:pan];
    
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
