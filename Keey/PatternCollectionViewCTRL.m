//
//  PatternCollectionViewCTRL.m
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PatternCollectionViewCTRL.h"
#import "KeyBoardStepSequencer.h"


@interface PatternCollectionViewCTRL ()

@end

@implementation PatternCollectionViewCTRL {
    KeyBoardStepSequencer *keyboardStepSeqViewCTRL;
}

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
    
    // Do any additional setup after loading the view.
    
    //[self addPatternInstrument:drumins];
    //[self addPatternInstrument:pianoins];
    //[self addPatternInstrument:trumpetins];
    //[self addPatternInstrument:guitarinns];

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

- (void) addPatternInstrument:(InstrumentButton *) sender {
    
    InstrumentButton *instrument = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    switch (sender.instrumentType) {
            
        case InstrumentalTypeDrums:
            [instrument ofType:InstrumentalTypeDrums ofSize:BigSize];
            _DrumPatternerCTRL = [[DrumPatternViewController alloc] init];
            [_currentPatterns addObject:_DrumPatternerCTRL];
            break;
            
        case InstrumentalTypePiano:
            [instrument ofType:InstrumentalTypePiano ofSize:BigSize];
            keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeTrumpet:
            [instrument ofType:InstrumentalTypeTrumpet ofSize:BigSize];
            keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeGuitar:
            [instrument ofType:InstrumentalTypeGuitar ofSize:BigSize];
            keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeFlute:
            [instrument ofType:InstrumentalTypeFlute ofSize:BigSize];
            keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeSynth:
            [instrument ofType:InstrumentalTypeSynth ofSize:BigSize];
            keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:keyboardStepSeqViewCTRL];
            break;
            
        case InstrumentalTypeVox:
            [instrument ofType:InstrumentalTypeVox ofSize:BigSize];
            keyboardStepSeqViewCTRL = [[KeyBoardStepSequencer alloc] init];
            [keyboardStepSeqViewCTRL setInstrumentButton:instrument];
            [_currentPatterns addObject:keyboardStepSeqViewCTRL];
            break;
            
        default:
            break;
            
    }
    
    
    [_patternInstruments addObject: instrument];

    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[_patternInstruments count]-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void) handleInstrumentClick: (InstrumentButton *)sender {
    [self.navigationController presentViewController:[_currentPatterns objectAtIndex:[sender tag]] animated:YES completion:nil];
        
}

@end
