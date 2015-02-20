//
//  DrumPatternViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 19/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "DrumPatternViewController.h"

@interface DrumPatternViewController () {
    UICollectionView *patternerCollectionView;
}

@end

@implementation DrumPatternViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.204 green:0.22 blue:0.22 alpha:1];
    
    _drums = [[Drums alloc] init];
    
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc]init];
    [myLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [myLayout setMinimumInteritemSpacing:30];
    [myLayout setMinimumLineSpacing:0];
    
    patternerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(125, 300, [self window_width]-250, 100) collectionViewLayout:myLayout];
    
    patternerCollectionView.backgroundColor = self.view.backgroundColor;
    [patternerCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [patternerCollectionView setDataSource:self];
    [patternerCollectionView setDelegate:self];

    [self.view addSubview:patternerCollectionView];
    
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval = CGSizeMake(60, 60);
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/*
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *touchedCell =[collectionView cellForItemAtIndexPath:indexPath];
    
    touchedCell.contentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1];
    
}*/

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *touchedCell =[collectionView cellForItemAtIndexPath:indexPath];
    
    if (![touchedCell isSelected]) {
        touchedCell.contentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1];
        return true;
    } else {
        [patternerCollectionView deselectItemAtIndexPath:indexPath animated:nil];
        touchedCell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
        return false;
    }
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

@end
