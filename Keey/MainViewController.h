//
//  MainViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"
#import "BodyView.h"
#import "BodyContentView.h"
#import "PatternViewController.h"
#import "PlaylistViewController.h"
#import <pop/POP.h>


@interface MainViewController : UIViewController

@property PatternViewController *patternViewCTRL;
@property PlaylistViewController *playlistViewCTRL;

@property BodyContentView *contentView;
@property UISegmentedControl *segControl;

@property UIView *selectedView;

@end
