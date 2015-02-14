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
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.204 green:0.22 blue:0.22 alpha:1];

    _instrumentButton = [[BubbleButton alloc] init];
    [_instrumentButton setSize:@"medium"];

    // Initialising sound objects
    _drums = [[Drums alloc] init];
    
    _piano = [[Piano alloc] init];
    //_piano = InstumentTypePiano;
    
    _patternInstruments =[[NSMutableArray alloc] initWithObjects:_drums,_piano, nil];
    
    
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
    
    /*
    _instrumentButton = [[BubbleButton alloc] initWithFrame:CGRectMake(100, 0, 200, 200)];
    
    if ([[_patternInstruments objectAtIndex:[indexPath row]] isKindOfClass:[Drums class]]) {
        
        _instrumentButton.backgroundColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:1];
        [_instrumentButton setLabelTitle:@"Drums"];
        
    } else if ([[_patternInstruments objectAtIndex:[indexPath row]] isKindOfClass:[Piano class]]) {
        
        _instrumentButton.backgroundColor = [UIColor colorWithRed:0.996 green:0.82 blue:0 alpha:1];
        [_instrumentButton setLabelTitle:@"Piano"];
        
    }
    
    [_instrumentButton setSize:@"medium"];
    [cell addSubview:_instrumentButton];
    */
    
    return cell;
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

- (void) addPatternInstrument:(NSObject *) instrument {
    [_patternInstruments addObject:instrument];
    [self.collectionView reloadData];
}

@end
