//
//  DrumPatternViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 19/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "SelectableViewCell.h"
#import <UIKit/UIKit.h>
#import "Drums.h"

@interface DrumPatternViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property Drums *drums;
@property NSMutableArray *soundRepresentation;

@end
