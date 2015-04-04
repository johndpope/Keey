//
//  PanelView.m
//  Keey
//
//  Created by Ipalibo Whyte on 14/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#import "PanelView.h"

@implementation PanelView

- (void) displayViewWithTitle: (NSString *)title {
    
    self.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    
    UIImage *btnImage = [[UIImage alloc] init];
    
    _panelHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self window_width], 60)];
    _panelHeader.backgroundColor = [UIColor colorWithRed:0.216 green:0.271 blue:0.294 alpha:1];
    [self addSubview:_panelHeader];
    
    UILabel *panelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self window_width], 60)];
    panelTitle.textColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    panelTitle.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    panelTitle.textAlignment = NSTextAlignmentCenter;
    panelTitle.text = @"Add an Instrument";
    [_panelHeader addSubview: panelTitle];
    
    _panelHeaderCloseBtn = [[UIButton alloc] initWithFrame:CGRectMake([self window_width]-60, 20, 20, 20)];
    btnImage = [UIImage imageNamed:@"closeicon.png"];
    [_panelHeaderCloseBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [_panelHeader addSubview:_panelHeaderCloseBtn];
}

- (void) displayContent: (NSArray *) instruments {
    
    _panelContent = [[UIView alloc] initWithFrame:CGRectMake(20, _panelHeader.frame.size.height +30, [self window_width]-40, 300)];
    [self addSubview:_panelContent];

    int spaceIncrement = 40;
    int count = 0;
    int spacey = 0;
    
    for (InstrumentButton *button in instruments) {
        
        [button setFrame:CGRectMake(spaceIncrement, spacey, button.frame.size.width, button.frame.size.height)];
        spaceIncrement += 256;
        
        if (([instruments count] - count) % 4 == 0 && count !=0){
            spacey = 150;
            spaceIncrement = 160;
        }
        
        [_panelContent addSubview:button];
        count++;
    }
    
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

@end
