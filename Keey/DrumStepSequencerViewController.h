//
//  DrumPatternViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 19/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drums.h"
#import "MarkerView.h"
#import "DrumViewModel.h"

@interface DrumPatternViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property Drums *drums;
@property DrumViewModel *drumModel;
@property NSMutableArray *kickSteps;
@property NSMutableArray *clapsSteps;
@property NSMutableArray *snareSteps;
@property NSMutableArray *hiHatSteps;

@property MarkerView *markerView;
@property UICollectionView *stepSequencerCollectionView;

@end
