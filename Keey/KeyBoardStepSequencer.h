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


@interface KeyBoardStepSequencer : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, CustomModalViewDelegate>

@property PianoRollConfig *config;
@property NSString *instrumentTitle;
@property UIColor *instrumentBgColor;

@end
