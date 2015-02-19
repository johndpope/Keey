//
//  PatternCollectionViewCTRL.m
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PatternCollectionViewCTRL.h"

@interface PatternCollectionViewCTRL ()

@end

@implementation PatternCollectionViewCTRL

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.204 green:0.22 blue:0.22 alpha:1];

    InstrumentButton *drumins = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [drumins ofType:InstrumentalTypeDrums ofSize:BigSize];
    
    InstrumentButton *pianoins = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [pianoins ofType:InstrumentalTypePiano ofSize:BigSize];
    
    InstrumentButton *trumpetins = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [trumpetins ofType:InstrumentalTypeTrumpet ofSize:BigSize];
    
    InstrumentButton *guitarinns = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [guitarinns ofType:InstrumentalTypeGuitar ofSize:BigSize];
    
    _patternInstruments =[[NSMutableArray alloc] initWithObjects:drumins,pianoins,trumpetins,guitarinns, nil];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_patternInstruments count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.contentView addSubview:[_patternInstruments objectAtIndex:[indexPath row]]];
    
    //cell.contentView.backgroundColor = [UIColor greenColor];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(190, 150);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void) addPatternInstrument:(InstrumentButton *) sender {
    
    InstrumentButton *instrument = [[InstrumentButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

    switch (sender.instrumentType) {
            
        case InstrumentalTypeDrums:
            [instrument ofType:InstrumentalTypeDrums ofSize:BigSize];
            break;
            
        case InstrumentalTypePiano:
            [instrument ofType:InstrumentalTypePiano ofSize:BigSize];
            break;
            
        case InstrumentalTypeTrumpet:
            [instrument ofType:InstrumentalTypeTrumpet ofSize:BigSize];
            break;
            
        case InstrumentalTypeGuitar:
            [instrument ofType:InstrumentalTypeGuitar ofSize:BigSize];
            break;
            
        case InstrumentalTypeFlute:
            [instrument ofType:InstrumentalTypeFlute ofSize:BigSize];
            break;
            
        case InstrumentalTypeSynth:
            [instrument ofType:InstrumentalTypeSynth ofSize:BigSize];
            break;
            
        case InstrumentalTypeVox:
            [instrument ofType:InstrumentalTypeVox ofSize:BigSize];
            break;
            
        default:
            break;
            
    }
    
    [_patternInstruments addObject: instrument];
    [self.collectionView reloadData];
}

@end
