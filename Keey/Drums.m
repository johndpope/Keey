//
//  Drums.m
//  Keey
//
//  Created by Ipalibo Whyte on 31/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "Drums.h"

@implementation Drums

-(instancetype) init {
    
    _kickSound = [[kicks alloc] init];
    _snareSound = [[Snares alloc] init];
    _clapSound = [[Claps alloc] init];
    _HiHats = [[HiHats alloc] init];
    
    return self;
}

- (void) playKick {
    [_kickSound playSound];
}

- (void) playClap {
    [_clapSound playSound];
}

- (void) playSnare {
    [_snareSound playSound];
}

- (void) playHats {
    [_HiHats playSound];
}

@end
