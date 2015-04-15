//
//  TimeViewPort.m
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "TimeViewPort.h"
#import <pop/POP.h>

@implementation TimeViewPort {
    UITapGestureRecognizer *tapGest;
    UITapGestureRecognizer *doubleTapGest;
    UIView *marker;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) init {
    self = [super init];
    
    if (self) {
        //_keyBoardSequencer = [[KeyBoardStepSequencer alloc] init];
        tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGest:)];
        tapGest.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGest];
        
        doubleTapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGest:)];
        doubleTapGest.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTapGest];
        
        [tapGest requireGestureRecognizerToFail:doubleTapGest];
    }
    
    return self;
}

- (void) displayTimeMarker {
    
    marker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    marker.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:0.4];
    [self addSubview:marker];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    maskLayer.path=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:maskRect.size.height/2].CGPath; // Considering the ImageView is square in Shape
    marker.layer.mask = maskLayer;
    
    [UIView animateWithDuration:2
                          delay:0
                        options: UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGRect oldFrame = marker.frame;
                         oldFrame.size.width = self.frame.size.width;
                         marker.frame = oldFrame;
                     }
                     completion:nil];
    
}

- (void) handleTapGest: (UIGestureRecognizer *)sender {
    [self.delegate HandleTimeViewPortTouch:self];
    
}

- (void) handleDoubleTapGest: (UIGestureRecognizer *)sender {
    [self.delegate HandleTimeViewPortDoubleTouch:self];
}

- (void) updateTimeViewStyle {
    
    POPSpringAnimation *anim;
    POPSpringAnimation *animBorderWidth;
    
    if (_isPlaying) {

        [marker removeFromSuperview];
        
        self.backgroundColor = [UIColor clearColor];
        //self.layer.borderWidth = 5;
        
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBorderColor];
        anim.toValue = (__bridge id)(_keyBoardSequencer.instrumentButton.backgroundColor.CGColor);
        anim.springSpeed = 30;
        anim.springBounciness = 5;
        anim.removedOnCompletion = YES;
        
        animBorderWidth = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBorderWidth];
        animBorderWidth.toValue = @5;
        animBorderWidth.springSpeed = 30;
        animBorderWidth.springBounciness = 15;
        animBorderWidth.removedOnCompletion = YES;

        
        anim.completionBlock = ^(POPAnimation *animation, BOOL finished){
            [self.layer pop_addAnimation:animBorderWidth forKey:@"springAnimation"];
        };
        
        [self.layer pop_addAnimation:anim forKey:@"springAnimation"];
        
    } else {
        
        [self displayTimeMarker];
        
        //self.layer.backgroundColor = [_keyBoardSequencer.instrumentButton.backgroundColor CGColor];
        
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        anim.toValue = (__bridge id)(_keyBoardSequencer.instrumentButton.backgroundColor.CGColor);
        anim.springSpeed = 30;
        anim.springBounciness = 10;
        anim.removedOnCompletion = YES;
        
        animBorderWidth = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBorderWidth];
        animBorderWidth.toValue = @0;
        animBorderWidth.springSpeed = 30;
        animBorderWidth.springBounciness = 0;
        animBorderWidth.removedOnCompletion = YES;
        
        animBorderWidth.completionBlock = ^(POPAnimation *animation, BOOL finished){
            [self.layer pop_addAnimation:anim forKey:@"springAnimation"];
        };

        [self.layer pop_addAnimation:animBorderWidth forKey:@"springAnimation"];

    }
    
    _isPlaying =!_isPlaying;
    
}

- (void) blinkPortView {
    
}


@end
