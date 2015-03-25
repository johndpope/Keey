//
//  PanelView.h
//  Keey
//
//  Created by Ipalibo Whyte on 14/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleButton.h"
#import "InstrumentButton.h"

@interface PanelView : UIView

@property UIView *panelHeader;
@property UIView *panelContent;
@property UIButton *panelHeaderCloseBtn;

- (void) displayViewWithTitle: (NSString *)title;
- (void) displayContent: (NSArray *) instruments;

@end
