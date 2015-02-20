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
    
    
    _soundRepresentation = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8; i++){
        [_soundRepresentation addObject:[NSNumber numberWithInt:0]];
    }
    
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
    
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(methodB:) userInfo:nil repeats:YES];

}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([_soundRepresentation objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]){
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
        cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
        
    } else if ([_soundRepresentation objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]){
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1];
        cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_soundRepresentation objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]) {

        [_soundRepresentation replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:1]];
        
    } else if ([_soundRepresentation objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]) {

        [_soundRepresentation replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:0]];
        
    }
    //NSLog(@"%@", _soundRepresentation);

    [collectionView reloadData];

}


/*
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *touchedCell =[collectionView cellForItemAtIndexPath:indexPath];
 
    if (![touchedCell isSelected]) {
        //[touchedCell setFrame:CGRectMake(0, 0, 80, 80)];
        //touchedCell.contentView.layer.cornerRadius = 40;
        touchedCell.contentView.layer.borderColor = [[UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:0.6] CGColor];
        touchedCell.contentView.layer.borderWidth = 8;
        touchedCell.contentView.backgroundColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1];
        [patternerCollectionView selectItemAtIndexPath:indexPath animated:nil scrollPosition:UICollectionViewScrollPositionNone];

        return true;
    } else {
        NSLog(@"should deselect");
        [patternerCollectionView deselectItemAtIndexPath:indexPath animated:nil];
        touchedCell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
        return false;
    }
}
 */

- (void) methodB:(NSTimer *)timer
{
    //[_drums playKick];
    [_drums playSnare];
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

@end
