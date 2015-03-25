//
//  PatternViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatternCollectionViewCTRL.h"
#import "InstrumentButton.h"
#import "BubbleButton.h"
#import "DrawerViewController.h"
#import <pop/POP.h>

@interface PatternViewController : UIViewController <DrawerViewControllerDelegate> {
    
}

@property PatternCollectionViewCTRL *patternCollectionCTRL;
@property BubbleButton *addInstrumentBtn;
@property DrawerViewController *drawerViewController;
@property NSArray *instrumentFactory;
@property InstrumentButton *instrumentButton;


@end
