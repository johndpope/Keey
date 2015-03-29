//
//  CustomModal.h
//  Keey
//
//  Created by Ipalibo Whyte on 22/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PianoRollConfig.h"

@class CustomModal;             //define class, so protocol can see MyClass
@protocol CustomModalViewDelegate <NSObject>   //define delegate protocol
- (void) CustomModalHandleOverlayTap: (CustomModal *) sender;  //define delegate method to be implemented within another class
- (void) CustomModalHandleBarChange: (int) bars;
- (void) CustomModalHandleOctaveChange: (OctaveType) octave;
- (void) CustomModalSwitchPreset: (NSUInteger) presetNumber;

@end //end protocol

@interface CustomModal : UIView

- (void) setupView;

@property (nonatomic, weak) id <CustomModalViewDelegate> delegate; //define MyClassDelegate as delegate

@end

