//
//  Drums.h
//  Keey
//
//  Created by Ipalibo Whyte on 31/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "kicks.h"
#import "Claps.h"
#import "Snares.h"
#import "HiHats.h"

@interface Drums : NSObject

@property NSArray *patternItems;
@property kicks *kickSound;
@property Claps *clapSound;
@property Snares *snareSound;
@property HiHats *HiHats;

- (void) playKick;
- (void) playClap;
- (void) playSnare;
- (void) playHats;

@end
