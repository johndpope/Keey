//
//  DrumPatternViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 19/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "SelectableViewCell.h"
#import <UIKit/UIKit.h>
#import "Drums.h"
#import "MarkerView.h"

@interface DrumPatternViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

typedef enum StepMood : NSUInteger {
    StepMoodKick,
    StepMoodClap,
    StepMoodSnare,
    StepMoodHiHats
    
} StepMood;

@property Drums *drums;
@property NSMutableArray *kickSteps;
@property NSMutableArray *clapsSteps;
@property NSMutableArray *snareSteps;
@property NSMutableArray *hiHatSteps;

@property MarkerView *markerView;
@property UICollectionView *stepSequencerCollectionView;

@end
