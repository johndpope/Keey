//
//  PlaylistCollectionViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 02/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PlaylistCollectionViewController.h"
#import "KeyBoardStepSequencer.h"
#import <pop/POP.h>

@interface PlaylistCollectionViewController ()

@end

@implementation PlaylistCollectionViewController

@synthesize patterns;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidAppear:(BOOL)animated {
    
    /*
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    animation.fromValue = [UIColor clearColor];
    animation.toValue = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:0.95];
    animation.springSpeed = 40;
    animation.springBounciness = 0;
    animation.removedOnCompletion = YES;
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished){
    };

    [self.view.layer pop_addAnimation:animation forKey:@"springAnimation"];
*/
}

- (void)viewDidDisappear:(BOOL)animated {
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    animation.fromValue = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:0.95];
    animation.toValue = [UIColor clearColor];
    animation.springSpeed = 40;
    animation.springBounciness = 0;
    animation.removedOnCompletion = YES;
    [self.view.layer pop_addAnimation:animation forKey:@"springAnimation"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *backgroundView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    backgroundView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+20);
    [self.view addSubview:backgroundView];
    [self.view bringSubviewToFront:self.collectionView];
    
    UITapGestureRecognizer *bgTouchGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundDidTouch:)];
    bgTouchGest.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:bgTouchGest];
    
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
        
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.frame = CGRectMake(150, 200, 720, 600);
    
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
    return [patterns count];
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150, 150);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(22, 15, 5, 22);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    //[cell.contentView addSubview:[_patterns objectAtIndex:[indexPath section]]];
    InstrumentButton *patternInstrument = [[InstrumentButton alloc] init];
        
    [patternInstrument ofType:[[(KeyBoardStepSequencer *)[patterns objectAtIndex:[indexPath row]] instrumentButton] instrumentType] ofSize:SmallSize];
    [patternInstrument setTitle:[[[(KeyBoardStepSequencer *)[patterns objectAtIndex:[indexPath row]] instrumentButton] titleLabel] text] forState:UIControlStateNormal];
    [patternInstrument addTarget:self action:@selector(patternDidclick:) forControlEvents:UIControlEventTouchUpInside];
    patternInstrument.tag = [indexPath row];
    [cell.contentView addSubview:patternInstrument];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    animation.springSpeed = 40;
    animation.springBounciness = 10;
    animation.removedOnCompletion = YES;

    [cell.layer pop_addAnimation:animation forKey:@"springAnimation"];
    
    return cell;
}

- (void) backgroundDidTouch: (UILongPressGestureRecognizer *)sender {
    
    [self.delegate HandleCollectionViewBodyTouch];
    
}

- (void) patternDidclick: (InstrumentButton *)sender {
    [self.delegate HandlePatternTouch:sender];
    [self.delegate HandleCollectionViewBodyTouch];
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

@end
