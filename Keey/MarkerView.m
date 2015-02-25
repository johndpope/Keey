//
//  MarkerView.m
//  Keey
//
//  Created by Ipalibo Whyte on 21/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "MarkerView.h"

@implementation MarkerView

- (void) displayHead {
    
    UILabel *markerHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    
    UIImageView *headimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Marker.png"]];
    [headimageview setFrame:CGRectMake(markerHead.center.x/2-15, 0, markerHead.frame.size.width, 20)];
    headimageview.contentMode = UIViewContentModeScaleAspectFit;

    [markerHead addSubview:headimageview];
    
    [self addSubview:markerHead];
}

- (void) displayMarkerLine {
    
    UIView *markerLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height)];
    
    markerLine.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:0.37];
    
    [self addSubview:markerLine];
}


@end
