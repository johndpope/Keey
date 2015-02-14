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
    [_patternItems initWithObjects:_kickSound,_snareSound,_clapSound,_HiHats, nil];
    
    return self;
}

@end
