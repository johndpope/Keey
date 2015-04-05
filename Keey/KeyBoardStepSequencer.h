//
//  KeyBoardStepSequencer.h
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CustomModal.h"
#import "PianoRollConfig.h"
#import "InstrumentButton.h"
#import "KeyboardViewModel.h"
#import "OctavePickerView.h"
#import "LongNoteView.h"


@class KeyBoardStepSequencer;             //define class, so protocol can see MyClass
@protocol KeyBoardStepSequencerDelegate <NSObject>   //define delegate protocol
- (void)  HandleKeyBoardStepSequencerClose: (UIViewController *)stepSequencerViewCtrl;  //define delegate method to be implemented within another class

@end //end protocol

@interface KeyBoardStepSequencer : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate,UITextFieldDelegate, CustomModalViewDelegate, OctavePickerViewDelegate>

@property PianoRollConfig *config;
@property InstrumentButton *instrumentButton;
@property KeyboardViewModel *keyboardViewModel;

@property (nonatomic, weak) id <KeyBoardStepSequencerDelegate> delegate; //define MyClassDelegate as delegate
@property int patternLenght;

- (void) stopMusicPlayer;
- (void) startMusicPlayer;

@end
