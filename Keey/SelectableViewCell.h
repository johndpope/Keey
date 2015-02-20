//
//  SelectableViewCell.h
//  Keey
//
//  Created by Ipalibo Whyte on 20/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectableViewCell : UICollectionViewCell {
    
}

@property UIColor *selectedBgColor;
@property UIColor *unselectedBgColor;

- (void) selectCell;

- (void) layoutViewProperties;

@end
