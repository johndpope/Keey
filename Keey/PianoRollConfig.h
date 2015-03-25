//
//  PianoRollConfig.h
//  Keey
//
//  Created by Ipalibo Whyte on 25/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PianoRollConfig : NSObject

typedef enum OctaveType : NSUInteger {
    
    OctaveTypeHigh = 2,
    OctaveTypeMid  = 1,
    OctaveTypeLow  = 0

} OctaveType;

@property int currentMeasure;
@property OctaveType currentOctave;

@end
