//
//  PlaylistPatternPortView.h
//  Keey
//
//  Created by Ipalibo Whyte on 02/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaylistPatternPortView;
@protocol PlaylistPatternPortViewDelegate <NSObject>

- (void) HandlePortHoldGesture: (UILongPressGestureRecognizer *)sender;

@end

@interface PlaylistPatternPortView : UIView

- (void) setUpPorts : (int)totalPorts;

@property (nonatomic, weak) id <PlaylistPatternPortViewDelegate> delegate; //define MyClassDelegate as delegate

@end