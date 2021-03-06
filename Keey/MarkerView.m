//
//  MarkerView.m
//  Keey
//
//  Created by Ipalibo Whyte on 21/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "MarkerView.h"

@implementation MarkerView {
    ;
}

- (void) displayHead {
    
    UILabel *markerHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    
    UIImageView *headimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Marker.png"]];
    [headimageview setFrame:CGRectMake(markerHead.center.x/2-15, 0, markerHead.frame.size.width, 20)];
    headimageview.contentMode = UIViewContentModeScaleAspectFit;

    [markerHead addSubview:headimageview];
    
    [self addSubview:markerHead];
}

- (void) displayMarkerLine {
    
    _markerLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0, 1, self.frame.size.height)];
    
    _markerLine.backgroundColor = [UIColor colorWithRed:1 green:0.518 blue:0.486 alpha:1];
    
    [self addSubview:_markerLine];
    
}

- (void) startAnimation: (int)duration toDestination: (int)dest {
    
    
    [UIView animateWithDuration:duration
                          delay:0
                        options: UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                            
                            CGRect oldframe = _markerLine.frame;
                            oldframe.origin.x =dest;
                            _markerLine.frame = oldframe;
                            
                        } completion:nil ];
    
}


@end
