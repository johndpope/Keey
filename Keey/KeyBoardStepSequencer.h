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


@interface KeyBoardStepSequencer : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, CustomModalViewDelegate, UITextFieldDelegate>

@property PianoRollConfig *config;
@property InstrumentButton *instrumentButton;

@end
