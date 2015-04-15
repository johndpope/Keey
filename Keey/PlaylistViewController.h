//
//  PlaylistViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistCollectionViewController.h"
#import "PlaylistPatternPortView.h"
#import "TimeViewPort.h"

@interface PlaylistViewController : UIViewController <PlaylistPatternCollectionViewDelegate, PlaylistPatternPortViewDelegate, TimeViewPortDelegate>

@property NSMutableArray *allPatterns;
@property NSMutableArray *allPatternsController;

- (void) handleUpdate;

@end
