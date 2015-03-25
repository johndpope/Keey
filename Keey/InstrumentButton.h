//
//  InstrumentButton.h
//  Keey
//
//  Created by Ipalibo Whyte on 18/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstrumentButton : UIButton

typedef enum InstrumentalType : NSUInteger {
    InstrumentalTypeDrums,
    InstrumentalTypePiano,
    InstrumentalTypeTrumpet,
    InstrumentalTypeGuitar,
    InstrumentalTypeFlute,
    InstrumentalTypeSynth,
    InstrumentalTypeVox
    
} InstrumentalType;

typedef enum InstrumentalSize : NSUInteger {
    BigSize,
    SmallSize
    
} InstrumentalSize;

- ( void ) ofType : (enum InstrumentalType) type ofSize : (enum InstrumentalSize) size;

@property (nonatomic, assign) InstrumentalType instrumentType;
@property (nonatomic, assign) InstrumentalSize instrumentSize;

@end
