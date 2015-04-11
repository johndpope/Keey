//
//  PatternCollectionViewCTRL.m
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "PatternCollectionViewCTRL.h"
#import "PopInTransition.h"
#import "PopOutTransition.h"

@interface PatternCollectionViewCTRL () <UIViewControllerTransitioningDelegate>

@end

@implementation PatternCollectionViewCTRL

static NSString * const reuseIdentifier = @"Cell";

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.collectionView.backgroundColor = [UIColor clearColor];

    InstrumentButton *drumins = [[InstrumentButton alloc] init];
    [drumins ofType:InstrumentalTypeDrums ofSize:BigSize];
    
    InstrumentButton *pianoins = [[InstrumentButton alloc] init];
    [pianoins ofType:InstrumentalTypePiano ofSize:BigSize];
    
    InstrumentButton *trumpetins = [[InstrumentButton alloc] init];
    [trumpetins ofType:InstrumentalTypeTrumpet ofSize:BigSize];
    
    InstrumentButton *guitarinns = [[InstrumentButton alloc] init];
    [guitarinns ofType:InstrumentalTypeGuitar ofSize:BigSize];
    
    //_patternInstruments =[[NSMutableArray alloc] initWithObjects:drumins,pianoins,trumpetins,guitarinns, nil];
    _patternInstruments =[[NSMutableArray alloc] init];
    
    _currentPatterns = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    

}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_patternInstruments count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.contentView addSubview:[_patternInstruments objectAtIndex:[indexPath row]]];
    [[_patternInstruments objectAtIndex:[indexPath row]] setTag:[indexPath row]];
    [[_patternInstruments objectAtIndex:[indexPath row]] addTarget:self action:@selector(handleInstrumentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(190, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, self.view.frame.size.width/2-40, 0, self.view.frame.size.width/2-110);
}

- (void) addPatternInstrument:(InstrumentButton *) sender {
    
    InstrumentButton *instrument = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    switch (sender.instrumentType) {
            
        case InstrumentalTypeDrums:
            [instrument ofType:InstrumentalTypeDrums ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypeDrums];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypePiano:
            [instrument ofType:InstrumentalTypePiano ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypePiano];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeTrumpet:
            [instrument ofType:InstrumentalTypeTrumpet ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypeTrumpet];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeGuitar:
            [instrument ofType:InstrumentalTypeGuitar ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypeGuitar];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeFlute:
            [instrument ofType:InstrumentalTypeFlute ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypeFlute];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeSynth:
            [instrument ofType:InstrumentalTypeSynth ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypeSynth];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeVox:
            [instrument ofType:InstrumentalTypeVox ofSize:BigSize];
            _keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [_keyboardStepSeqViewCTRL setPatternType:InstrumentTypeVox];
            [_keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:_keyboardStepSeqViewCTRL];
            break;
            
        default:
            break;
            
    }
    
    [_keyboardStepSeqViewCTRL setDelegate:self];

    [_patternInstruments addObject: instrument];

    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[_patternInstruments count]-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void) handleInstrumentClick: (InstrumentButton *)sender {
    
        UIViewController *vc = [_currentPatterns objectAtIndex:[sender tag]];

        vc.view.frame = CGRectMake(0, 0, [self window_width], [self window_height]);
    
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];

}

- (void)HandleKeyBoardStepSequencerClose:(KeyBoardStepSequencer *)stepSequencerViewCtrl {
    [stepSequencerViewCtrl stopMusicPlayer];
}

#pragma mark - Transitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PopInTransition new];
}

#pragma mark - Transitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PopOutTransition new];
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
