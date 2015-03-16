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
#import "InstrumentalHeaderView.h"
#import "MusicSequencerModel.h"

@interface DrumPatternViewController () {
    
    InstrumentalHeaderView *headerView;
    UIView *sequencerContainerView;
    NSUInteger markerPosition;
    UITableView *tableView;
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
    
    
    //[self layoutInstrumentButtons];

    headerView = [[InstrumentalHeaderView alloc] initWithFrame:CGRectMake(0, 0, 120, 360)];
    [headerView setUpHeaders:6 withType:HeaderTypeDetailed];
    
    [sequencerContainerView addSubview:headerView];
    
    [self setUpNavBar];
    
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
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodKick]) {

                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            case 1:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodSnare]) {
                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            case 2:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodClap]) {
                    cell.backgroundColor = [UIColor colorWithRed:1 green:0.855 blue:0.741 alpha:1];
                }
                break;
                
            case 3:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodHiHats]) {
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
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodKick]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
            
            case 1:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodSnare]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
                
            case 2:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodClap]) {
                    cell.backgroundColor = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
                }
                break;
                
            case 3:
                
                if ([_drumModel shouldPlaySoundAt:[indexPath row] forInstrument:DrumMoodHiHats]) {
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
    return UIEdgeInsetsMake(30, 0, 30, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%d", [indexPath row]);
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
    
    if([_drumModel shouldPlaySoundAt:markerPosition forInstrument:DrumMoodKick]){
        [_drums playKick];
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forInstrument:DrumMoodClap]){
        [_drums playClap];
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forInstrument:DrumMoodSnare]){
        [_drums playSnare];
    }
    
    if([_drumModel shouldPlaySoundAt:markerPosition forInstrument:DrumMoodHiHats]){
        [_drums playHats];
    }
    
    [self updateMarkerPosition];

    
    markerPosition++;

    
}

- (void) dismissviewctrl {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    sequencerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [self window_width], 360)];
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
    
    /*
    int yPos = 0;
    for (int i = 0; i < 4; i++) {
        
        UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, 120, sequencerContainerView.frame.size.height/4)];
        headerView.backgroundColor = [UIColor colorWithRed:0.18 green:0.224 blue:0.247 alpha:1];
        headerView.textColor = [UIColor colorWithRed:0.122 green:0.157 blue:0.169 alpha:1];
        headerView.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
        headerView.textAlignment = NSTextAlignmentCenter;

        switch (i) {
                
            case 0:
                [headerView setText:@"Kicks"];
                break;
                
            case 1:
                [headerView setText:@"Claps"];
                break;
                
            case 2:
                [headerView setText:@"Snares"];
                break;
                
            case 3:
                [headerView setText:@"Hi hats"];
                break;
                
            default:
                break;
        }
        yPos = (sequencerContainerView.frame.size.height/4)*(i+1);
        [sequencerContainerView addSubview:headerView];
    }
    */
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 360)];
    [sequencerContainerView addSubview:tableView];
    [sequencerContainerView addSubview:_stepSequencerCollectionView];
}

- (void) setUpNavBar {
    
    UIView *custNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self window_width], 75)];
    custNavBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:custNavBar];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(custNavBar.frame.size.width-70, 25, 30, 30)];
    [closeButton addTarget:self action:@selector(dismissviewctrl) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [custNavBar addSubview:closeButton];
    
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(custNavBar.frame.size.width-150, 25, 28, 28)];
    //[settingsButton addTarget:self action:@selector(dismissviewctrl) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    //[custNavBar addSubview:settingsButton];
    
}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
