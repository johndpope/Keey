//
//  KeyBoardStepSequencer.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define MAXLENGTH 10

#import "KeyBoardStepSequencer.h"
#import "InstrumentalHeaderView.h"
#import "MusicSequencerModel.h"
#import "KeyboardViewModel.h"
#import "BeatBarHeaderView.h"
#import "PianoRollConfig.h"
#import "StepViewCell.h"
#import "MarkerView.h"
#import "StepState.h"
#import <pop/POP.h>


@interface KeyBoardStepSequencer () {
    
    UICollectionView *seqcollectionview;
    InstrumentalHeaderView *keyboardView;
    UIView *sequencerContainerView;
    UIView *custNavBar;
    NSIndexPath *currentHighlightedIndexPath;
    int currentHighlightedIndexPathLength;
    MarkerView *marker;
    CustomModal *customModalMenu;
    OctavePickerView *noteOctavePickerView;
    BeatBarHeaderView *barheaderView;
    StepViewCell *customCell;
    LongNoteView *longNoteView;
    LongNoteView *currentHighlightednote;
    
    int numberofSections;
    
    UIButton *firstBarControlBtn;
    UIButton *secondBarControlBtn;
    
    UIView *currentBarIndicatorViwContainer;
    
    BOOL isfirstTimeAppearing;
    BOOL wasIntersected;

}

@end

@implementation KeyBoardStepSequencer

@synthesize instrumentButton;
@synthesize patternLenght;
@synthesize patternType;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidAppear:(BOOL)animated {
    
    if (!isfirstTimeAppearing) {
        
    marker = [[MarkerView alloc] initWithFrame:CGRectMake(0, 0, 1, seqcollectionview.frame.size.height)];
    [marker displayMarkerLine];
    [seqcollectionview addSubview:marker];
    [marker startAnimation:2 toDestination:seqcollectionview.frame.size.width];
    
    _keyboardViewModel = [[KeyboardViewModel alloc] init];
    [_keyboardViewModel createStepStatesWithSections:numberofSections withKeyNoteCount:12];
    [_keyboardViewModel setupKeys:16 withInstrument:patternType];
    [_keyboardViewModel.config setInstrumentType:patternType];

        isfirstTimeAppearing = true;
        
        //CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkHandler)];
        //[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    } else {
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    
    [self setUpNavBar];
    
    numberofSections = 16;
    
    [self setUpSequencerView];
    
    [self setUpModalView];
    
    noteOctavePickerView = [[OctavePickerView alloc] initWithFrame:self.view.frame];
    [noteOctavePickerView setupView];
    [noteOctavePickerView setupDashboard];
    [noteOctavePickerView setOctavePickerDelegate:self];
    [self.view addSubview:noteOctavePickerView];
    noteOctavePickerView.hidden = YES;

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
    
    if ([_keyboardViewModel isStateSelectedAt:[indexPath row] positionInPianoRoll:[indexPath section]]) {
        
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
    
    if ([_keyboardViewModel isStateSelectedAt:[indexPath row] positionInPianoRoll:[indexPath section]]) {
        
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
    [keyboardView setTotalNotes:12];
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
    
    UITextField *instumentTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 20, 100, 40)];
    //[instumentTitleBtn setBackgroundColor: [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1]];
    [instumentTitleTextField setBackgroundColor: [UIColor colorWithRed:0.141 green:0.184 blue:0.204 alpha:1]];
    instumentTitleTextField.layer.borderColor = instrumentButton.backgroundColor.CGColor;
    instumentTitleTextField.layer.borderWidth = 2;
    instumentTitleTextField.textAlignment = NSTextAlignmentCenter;
    instumentTitleTextField.textColor = [UIColor whiteColor];
    instumentTitleTextField.text = instrumentButton.titleLabel.text;
    instumentTitleTextField.font = [UIFont fontWithName:@"Gotham Rounded" size:12];
    instumentTitleTextField.layer.cornerRadius = 20;
    [instumentTitleTextField setDelegate:self];
    instumentTitleTextField.returnKeyType = UIReturnKeyDone;
    [instumentTitleTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];

    [custNavBar addSubview:instumentTitleTextField];
    
}

- (void) handleMenuButtonClick {
    [self displayModal:customModalMenu];
}

- (void) handleBarSwitch: (UIButton *)sender {
    
    switch (sender.tag) {
            
        case 1:
            [seqcollectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            break;
            
        case 2:

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

- (void) displayModal: (CustomModal *)sender {
        
    if ([sender isHidden]) {
                
        [sender setHidden:NO];
        [sender.dashboardView setHidden:YES];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
        anim.fromValue = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        anim.toValue = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:0.2];
        //anim.toValue = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        anim.springSpeed = 30;
        anim.springBounciness = 0;
        anim.removedOnCompletion = YES;
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
            
            [sender.dashboardView setHidden:NO];
            
            POPSpringAnimation *animframe = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            animframe.fromValue = [NSNumber numberWithFloat:[self window_height]];
            animframe.toValue = [NSNumber numberWithFloat:[self window_height]/2];
            animframe.velocity = [NSNumber numberWithFloat:50];
            animframe.springSpeed = 30;
            animframe.springBounciness = 10;
            animframe.removedOnCompletion = YES;
            
            [sender.dashboardView.layer pop_addAnimation:animframe forKey:@"springAnimation"];

        };
        
        [sender.background pop_addAnimation:anim forKey:@"springAnimation"];


        
    } else {
        
        POPSpringAnimation *animframe = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        animframe.toValue = [NSNumber numberWithFloat:[self window_height]+200];
        animframe.velocity = [NSNumber numberWithFloat:50];
        animframe.springSpeed = 30;
        animframe.springBounciness = 0;
        animframe.removedOnCompletion = YES;
        
        [sender.dashboardView.layer pop_addAnimation:animframe forKey:@"springAnimation"];
        
        animframe.completionBlock = ^(POPAnimation *animpop, BOOL finished){

        };
        
        [sender.dashboardView setHidden:NO];
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
        anim.toValue = [UIColor clearColor];
        anim.springSpeed = 30;
        anim.springBounciness = 0;
        anim.removedOnCompletion = YES;
        
        anim.completionBlock = ^(POPAnimation *animpop, BOOL finished){
            
            [sender setHidden:YES];
        };
        
        [sender.background pop_addAnimation:anim forKey:@"springAnimation"];
    }
    
}

- (void) setUpModalView {
    
    customModalMenu = [[CustomModal alloc] initWithFrame:CGRectMake(0, 0, [self window_width], [self window_height])];
    [customModalMenu setupView];
    [customModalMenu setHidden:YES];
    [self.view addSubview:customModalMenu];
    
    [customModalMenu setDelegate:self];
    
}

- (void) HandleOctaveOverlayTap: (CustomModal *)sender {
    [self displayModal:sender];
}

- (void) CustomModalHandleOverlayTap:(CustomModal *)sender {
    [self displayModal:sender];
}

- (void) CustomModalHandleBarChange: (int) bars {
    
    if (bars == 2) {

        // 32 beats 2bars
        numberofSections = 32;
        [_keyboardViewModel handleBarChangewithBars:2];
        [seqcollectionview reloadData];
        
        [secondBarControlBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        currentBarIndicatorViwContainer.hidden = NO;
        
    } else {
        
        // 16 beats 1bars
        
        numberofSections = 16;
        [_keyboardViewModel handleBarChangewithBars:1];
        [seqcollectionview reloadData];
        
        [firstBarControlBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        currentBarIndicatorViwContainer.hidden = YES;
        
    }

    
}

- (void) CustomModalHandleOctaveChange:(OctaveType)octave {
    
    switch (octave) {
            
        case OctaveTypeHigh:
            [_keyboardViewModel handleOctaveChange:octave];
            break;
            
        case OctaveTypeMid:
            [_keyboardViewModel handleOctaveChange:octave];
            break;
            
        case OctaveTypeLow:
            [_keyboardViewModel handleOctaveChange:octave];
            break;
            
        default:
            break;
    }
}

- (void) CustomModalSwitchPreset: (NSInteger) presetNumber {

    [_keyboardViewModel handleSwitchPreset:presetNumber];
}

- (void) HandleNoteOctaveChange:(int)octaveIndex {
    
    switch (octaveIndex) {
            
        case 1:
            [_keyboardViewModel updateNoteOctaveForNoteAt:[currentHighlightedIndexPath section] withOctave:OctaveTypeLow withKeyNote:[currentHighlightedIndexPath row]];
            [currentHighlightednote setBackgroundColor:[UIColor colorWithRed:0.671 green:0.557 blue:0.467 alpha:1]];

            break;
        
        case 2:
            [_keyboardViewModel updateNoteOctaveForNoteAt:[currentHighlightedIndexPath section] withOctave:OctaveTypeMid withKeyNote:[currentHighlightedIndexPath row]];
            [currentHighlightednote setBackgroundColor:[UIColor colorWithRed:0.831 green:0.69 blue:0.58 alpha:1]];


            break;
        
        case 3:
            [_keyboardViewModel updateNoteOctaveForNoteAt:[currentHighlightedIndexPath section] withOctave:OctaveTypeHigh withKeyNote:[currentHighlightedIndexPath row]];
            [currentHighlightednote setBackgroundColor:[UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1]];

            break;
            
        default:
            break;
    }
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

- (void) handleNoteTap: (UIGestureRecognizer *)sender {
    
    LongNoteView *longNote = (LongNoteView *)sender.view;
    
    [self bounceNote:longNote];
    
    currentHighlightedIndexPath = longNote.noteIndexPath;
    currentHighlightednote = longNote;
    
    [self displayModal:noteOctavePickerView];
    
}

- (void) bounceNote: (LongNoteView *)noteView {
    
    POPSpringAnimation *bounceAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    bounceAnim.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.8, 0.8)];
    bounceAnim.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    bounceAnim.springSpeed = 40;
    bounceAnim.springBounciness = 10;
    bounceAnim.removedOnCompletion = YES;
    [noteView.layer pop_addAnimation:bounceAnim forKey:@"springAnimation"];
}

- (void) drawChord: (NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [seqcollectionview cellForItemAtIndexPath:indexPath];

    longNoteView = [[LongNoteView alloc] init];
    longNoteView.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 92, 34);
    longNoteView.layer.cornerRadius = 17;
    longNoteView.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
    [longNoteView setNoteIndexPath:indexPath];
    
    [seqcollectionview addSubview:longNoteView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:) ];
    [pan setDelegate:self];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [longNoteView addGestureRecognizer:pan];
    
    [self pan:pan];
    
    UITapGestureRecognizer * tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNoteTap:) ];
    [longNoteView addGestureRecognizer:tapGest];
    
    [self addStepToSequencer:indexPath withLength:2];
    
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

    [_keyboardViewModel updateStepSeqForPosition:[indexPath section] withlength:length withKeyNote:[indexPath row]];
    
}

- (void) dismissviewctrl {
    //[seqcollectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:30] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    [self.delegate HandleKeyBoardStepSequencerClose:self];
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

- (void) displayLinkHandler {
    
    id presentationLayer1 = marker.markerLine.layer.presentationLayer;
    
    for (NSIndexPath* cellPath in [seqcollectionview indexPathsForVisibleItems]) {
        
        UICollectionViewCell *cell = [seqcollectionview cellForItemAtIndexPath:cellPath];
        
        id presentationLayer2 = cell.layer.presentationLayer;
        
        BOOL nowIntersecting = CGRectIntersectsRect([presentationLayer1 frame], [presentationLayer2 frame]);
        
        // I'll keep track of whether the two views were intersected in a class property,
        // and therefore only display a message if the intersected state changes.
        
        if (nowIntersecting != wasIntersected) {
            
            if (nowIntersecting && [_keyboardViewModel isStateSelectedAt:[cellPath row] positionInPianoRoll:[cellPath section]]) {
                //NSLog(@"row is: %d section is: %d", [cellPath row], [cellPath section]);
                
                cell.backgroundColor = [UIColor whiteColor];

 
            }else{
                
                
                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];

                //cell.backgroundColor = [UIColor clearColor];
                //NSLog(@"imageviews no longer intersecting");
            }
            wasIntersected = nowIntersecting;
        }
    }

}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= MAXLENGTH || returnKey;
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [instrumentButton setTitle:textField.text forState:UIControlStateNormal];
    [textField resignFirstResponder];
    
    return true;
}

- (void) stopMusicPlayer {
    [_keyboardViewModel handleMusicControl:MusicPlayerControlTypeStop];
}

- (void) startMusicPlayer {
    [_keyboardViewModel handleMusicControl:MusicPlayerControlTypeStart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
