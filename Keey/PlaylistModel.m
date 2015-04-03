//
//  PlaylistModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PlaylistModel.h"

@implementation PlaylistModel

- (void) HandlePatternPortInsert: (KeyBoardStepSequencer *) sender {
    NSLog(@"name is : %@", sender.instrumentButton.titleLabel.text);
    [sender startMusicPlayer];
}

@end
