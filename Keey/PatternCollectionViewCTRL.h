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
#import "DrumStepSequencerViewController.h"
#import "KeyBoardStepSequencer.h"
#import "PianoRollConfig.h"


@class PatternCollectionViewCTRL;
@protocol PatternCollectionViewCTRLDelegate <NSObject>

- (void) updatePlaylistPatterns: (NSMutableArray *) patterns;

@end

@interface PatternCollectionViewCTRL : UICollectionViewController <KeyBoardStepSequencerDelegate> {
    
        id<UINavigationControllerDelegate> _navDelegate;
}


@property NSMutableArray *currentPatterns;
@property NSMutableArray *patternInstruments;

@property DrumPatternViewController *DrumPatternerCTRL;
@property KeyBoardStepSequencer *keyboardStepSeqViewCTRL;

@property Drums *drums;
@property Piano *piano;
@property BubbleButton* instrumentButton;
@property (nonatomic, weak) id <PatternCollectionViewCTRLDelegate> delegate; //define MyClassDelegate as delegate

- (void) addPatternInstrument:(UIButton *) instrument;

@end
