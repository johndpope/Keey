//
//  TimeViewPort.m
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "TimeViewPort.h"

@implementation TimeViewPort

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) displayTimeMarker {
    
    UIView *marker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    marker.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:0.4];
    [self addSubview:marker];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    maskLayer.path=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:maskRect.size.height/2].CGPath; // Considering the ImageView is square in Shape
    marker.layer.mask = maskLayer;
    
    [UIView animateWithDuration:2
                          delay:0
                        options: UIViewAnimationCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         CGRect oldFrame = marker.frame;
                         oldFrame.size.width = self.frame.size.width;
                         marker.frame = oldFrame;
                     }
                     completion:nil];
}

@end
