//
//  OctavePickerView.h
//  Keey
//
//  Created by Ipalibo Whyte on 05/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModal.h"

@class OctavePickerView;
@protocol OctavePickerViewDelegate <NSObject>

- (void) HandleNoteOctaveChange: (int)octaveIndex;
- (void) HandleOctaveOverlayTap: (CustomModal *)sender;
- (void) HandleNoteDeleteTouch;

@end

@interface OctavePickerView : CustomModal

- (void) setupView;
- (void) setupDashboard;
- (void) selectOctaveIndex: (int) index;


@property (nonatomic, weak) id <OctavePickerViewDelegate> octavePickerDelegate; //define MyClassDelegate as delegate


@end
