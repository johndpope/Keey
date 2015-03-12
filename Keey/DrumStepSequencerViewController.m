//
//  DrumPatternViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 19/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "DrumStepSequencerViewController.h"
#import "MusicSequencerModel.h"

@interface DrumPatternViewController () {
    
    NSUInteger markerPosition;
    UIView *sequencerContainerView;
    NSUInteger totalSteps;
    //MusicSequencerModel *musicSeq;
    //StepMood currentMood;
    
}

@end

@implementation DrumPatternViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    
    _drums = [[Drums alloc] init];
    _drumModel = [[DrumViewModel alloc] init];
    [_drumModel setupDrumIntruments:16];
    
    //currentMood = StepMoodKick;
    
    [self setUpSequencerView];
    
    [self setUpMarker];

    
    markerPosition = 0;
    
    
    
    //[NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(playSoundAtMarker:) userInfo:nil repeats:YES];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissviewctrl)];
    
    tapRecog.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:tapRecog];
    
    //[self layoutInstrumentButtons];

}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20; // This is the minimum inter item spacing, can be more
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    if([indexPath row] % 8 < 4) {
        
        switch ([indexPath section]) {
                
            case 0:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodKick]) {

                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            case 1:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodSnare]) {
                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            case 2:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodClap]) {
                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            case 3:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodHiHats]) {
                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            default:
                break;
        }
    
        cell.layer.borderColor = [[UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1] CGColor];

    } else {
        
        switch ([indexPath section]) {
                
            case 0:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodKick]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
            
            case 1:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodSnare]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
                
            case 2:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodClap]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
                
            case 3:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forIntrument:DrumMoodHiHats]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
                
            default:
                break;
        }
        
        cell.layer.borderColor = [[UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1] CGColor];

    }

    cell.layer.borderWidth = 2;
    cell.layer.cornerRadius = cell.frame.size.width/2;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(33, 33);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(25, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0., 30.);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath section] == 0){

        [_drumModel updateStepAt:[indexPath row] forInstrument:DrumMoodKick];
        
    } else if ([indexPath section] == 1) {
        
        [_drumModel updateStepAt:[indexPath row] forInstrument:DrumMoodSnare];
        
    } else if ([indexPath section] == 2) {
        
        [_drumModel updateStepAt:[indexPath row] forInstrument:DrumMoodClap];
        
    } else if ([indexPath section] == 3) {
        
        [_drumModel updateStepAt:[indexPath row] forInstrument:DrumMoodHiHats];
        
    }

    [_stepSequencerCollectionView reloadData];

}

- (void) playSoundAtMarker:(NSTimer *)timer
{
    
    if (markerPosition >= 16) {
        markerPosition = 0;
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forIntrument:DrumMoodKick]){
        [_drums playKick];
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forIntrument:DrumMoodClap]){
        [_drums playClap];
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forIntrument:DrumMoodSnare]){
        [_drums playSnare];
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forIntrument:DrumMoodHiHats]){
        [_drums playHats];
    }
    
    [self updateMarkerPosition];

    
    markerPosition++;

    
}

- (void) dismissviewctrl {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) layoutInstrumentButtons {
    
}

- (void) handleInstrumentButtonTouch: (UIButton *) sender {


}

- (void) setUpMarker {
    _markerView = [[MarkerView alloc] init];
    [_markerView setFrame:CGRectMake(0, 0, 1, sequencerContainerView.frame.size.height)];
    //[_markerView displayHead];
    [_markerView displayMarkerLine];
    [_stepSequencerCollectionView addSubview:_markerView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateMarkerPosition];
    });



}

- (void) updateMarkerPosition {
    
    
    [UIView animateKeyframesWithDuration:0.3
                                   delay:0
                                 options: UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  CGRect oldFrame = _markerView.frame;
                                  if (markerPosition == 0) {
                                      oldFrame.origin.x = 0;
                                  }else{
                                      oldFrame.origin.x += 54;
                                  }
                                  _markerView.frame = oldFrame;
                                  
                              }
                              completion:nil];
    
}

- (void) setUpSequencerView {
    sequencerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [self window_width], 400)];
    sequencerContainerView.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    [self.view addSubview:sequencerContainerView];
    
    UICollectionViewFlowLayout *sequencerLayout = [[UICollectionViewFlowLayout alloc]init];
    [sequencerLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [sequencerLayout setMinimumLineSpacing:0];
    
    _stepSequencerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(130, 0, sequencerContainerView.frame.size.width-130, 400) collectionViewLayout:sequencerLayout];
    [_stepSequencerCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    _stepSequencerCollectionView.backgroundColor = [UIColor clearColor];
    [_stepSequencerCollectionView setDataSource:self];
    [_stepSequencerCollectionView setDelegate:self];
    
    [sequencerContainerView addSubview:_stepSequencerCollectionView];
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

@end
