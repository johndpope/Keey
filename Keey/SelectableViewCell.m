//
//  SelectableViewCell.m
//  Keey
//
//  Created by Ipalibo Whyte on 20/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "SelectableViewCell.h"

@implementation SelectableViewCell {
    BOOL selected;
}

@synthesize selectedBgColor;

- (void) layoutViewProperties {
    
    NSLog(@"LETS SEE!!!");
    
    //_unselectedBgColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    //self.layer.cornerRadius = self.frame.size.height/2;
    //self.backgroundColor = _unselectedBgColor;
    
}

- (void) selectCell {
    
    selected = true;
    self.backgroundColor = selectedBgColor;
    
}

@end
