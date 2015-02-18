//
//  PatternCollectionViewCTRL.h
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleButton.h"
#import "Drums.h"
#import "Piano.h"
#import "InstrumentButton.h"

@interface PatternCollectionViewCTRL : UICollectionViewController

typedef NS_ENUM (NSInteger, InstumentType) {
    InstumentTypeDrums,
    InstumentTypePiano,
    InstumentTypeTrumpets,
};


@property BubbleButton *instrumentButton;
@property NSMutableArray *patternInstruments;
@property Drums *drums;
@property Piano *piano;

- (void) addPatternInstrument:(UIButton *) instrument;

@end
