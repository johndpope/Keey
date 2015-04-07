//
//  PlaylistCollectionViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 02/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstrumentButton.h"


@class PlaylistCollectionViewController;
@protocol PlaylistPatternPortViewDelegate <NSObject>

- (void) HandleCollectionViewBodyTouch;
- (void) HandlePatternTouch: (InstrumentButton *) sender;

@end

@interface PlaylistCollectionViewController : UICollectionViewController

@property NSMutableArray *patterns;

@property (nonatomic, weak) id <PlaylistPatternPortViewDelegate> delegate; //define MyClassDelegate as delegate


@end
