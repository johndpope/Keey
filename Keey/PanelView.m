//
//  PanelView.m
//  Keey
//
//  Created by Ipalibo Whyte on 14/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PanelView.h"

@implementation PanelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) displayViewWithTitle: (NSString *)title {
    
    self.backgroundColor = [UIColor colorWithRed:0.204 green:0.22 blue:0.22 alpha:1];
    
    _panelHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self window_width], 60)];
    _panelHeader.backgroundColor = [UIColor colorWithRed:0.271 green:0.298 blue:0.298 alpha:1];
    [self addSubview:_panelHeader];
    
    UILabel *panelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self window_width], 60)];
    panelTitle.text = @"Add an Instrument";
    panelTitle.textAlignment = NSTextAlignmentCenter;
    panelTitle.textColor = [UIColor whiteColor];
    panelTitle.font = [UIFont systemFontOfSize:15];
    panelTitle.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
    [_panelHeader addSubview: panelTitle];
}


- (CGFloat) window_height {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

- (CGFloat) window_width {
    return [UIScreen mainScreen].applicationFrame.size.width;
}

@end
