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
    panelTitle.textColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    panelTitle.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    panelTitle.textAlignment = NSTextAlignmentCenter;
    panelTitle.text = @"Add an Instrument";
    [_panelHeader addSubview: panelTitle];
}

- (void) displayContent: (NSArray *) instruments {
    
    _panelContent = [[UIView alloc] initWithFrame:CGRectMake(20, _panelHeader.frame.size.height +30, [self window_width]-40, 300)];
    NSLog(@"%f", [self window_width]);
    [self addSubview:_panelContent];

    int spaceIncrement = 40;
    
    for (InstrumentButton *button in instruments) {
        [button setFrame:CGRectMake(spaceIncrement, 0, button.frame.size.width, button.frame.size.height)];
        spaceIncrement +=256;
        [_panelContent addSubview:button];
    }
    
}


- (CGFloat) window_height {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

- (CGFloat) window_width {
    return [UIScreen mainScreen].applicationFrame.size.width;
}

@end
