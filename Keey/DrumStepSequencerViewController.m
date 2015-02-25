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

@interface DrumPatternViewController () {
    
    NSUInteger markerPosition;
    UIView *sequencerContainerView;
    NSUInteger totalSteps;
    StepMood currentMood;
    
}

@end

@implementation DrumPatternViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.204 green:0.22 blue:0.22 alpha:1];
    
    _drums = [[Drums alloc] init];
    
    _kickSteps = [[NSMutableArray alloc] init];
    _clapsSteps = [[NSMutableArray alloc] init];
    _snareSteps = [[NSMutableArray alloc] init];
    _hiHatSteps = [[NSMutableArray alloc] init];
    
    totalSteps = 8;

    for (int i = 0 ; i < totalSteps; i++){
        
        [_kickSteps addObject:[NSNumber numberWithInt:0]];
        [_clapsSteps addObject:[NSNumber numberWithInt:0]];
        [_snareSteps addObject:[NSNumber numberWithInt:0]];
        [_hiHatSteps addObject:[NSNumber numberWithInt:0]];
        
    }
    currentMood = StepMoodKick;
    sequencerContainerView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, [self window_width]-90, 200)];
    [self.view addSubview:sequencerContainerView];
    
    UICollectionViewFlowLayout *sequencerLayout = [[UICollectionViewFlowLayout alloc]init];
    [sequencerLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [sequencerLayout setMinimumLineSpacing:0];
    
     _stepSequencerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 150, sequencerContainerView.frame.size.width, 100) collectionViewLayout:sequencerLayout];
    [_stepSequencerCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
     _stepSequencerCollectionView.backgroundColor = self.view.backgroundColor;
    [_stepSequencerCollectionView setDataSource:self];
    [_stepSequencerCollectionView setDelegate:self];

    [sequencerContainerView addSubview:_stepSequencerCollectionView];
    
    markerPosition = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:0.20 target:self selector:@selector(playSoundAtMarker:) userInfo:nil repeats:YES];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissviewctrl)];
    
    tapRecog.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:tapRecog];
    
    _markerView = [[MarkerView alloc] init];
    [_markerView setFrame:CGRectMake(0, 0, 60, 400)];
    [_markerView displayHead];
    [_markerView displayMarkerLine];
    [sequencerContainerView addSubview:_markerView];
    
    [self layoutInstrumentButtons];

}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return totalSteps;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return totalSteps; // This is the minimum inter item spacing, can be more
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch (currentMood) {
            
        case StepMoodKick:
            
            if ([_kickSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]){
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
                
            } else if ([_kickSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]){
                cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0.875 blue:0.988 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
            }

            break;
            
        case StepMoodClap:

            if ([_clapsSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]){
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
                
            } else if ([_clapsSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]){
                cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0.875 blue:0.988 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
            }
            
            break;
        
        case StepMoodSnare:

            if ([_snareSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]){

                cell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
                
            } else if ([_snareSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]){
                cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0.875 blue:0.988 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
            }
            
            break;
            
        case StepMoodHiHats:
            
            if ([_hiHatSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]){
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
                
            } else if ([_hiHatSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]){
                cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0.875 blue:0.988 alpha:1];
                cell.contentView.layer.cornerRadius = cell.contentView.frame.size.height/2;
            }
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (currentMood) {

        case StepMoodKick:
            
            if ([_kickSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]) {
                
                [_kickSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:1]];
                
            } else if ([_kickSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]) {
                
                [_kickSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:0]];
                
            }
            
            break;
            
        case StepMoodClap:
            
            if ([_clapsSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]) {
                
                [_clapsSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:1]];
                
            } else if ([_clapsSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]) {
                
                [_clapsSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:0]];
                
            }
            
            break;
            
        case StepMoodSnare:
            
            if ([_snareSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]) {
                
                [_snareSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:1]];
                
            } else if ([_snareSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]) {
                
                [_snareSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:0]];
                
            }
            
            break;
            
        case StepMoodHiHats:
            
            if ([_hiHatSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:0]) {
                
                [_hiHatSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:1]];
                
            } else if ([_hiHatSteps objectAtIndex:[indexPath row]] == [NSNumber numberWithInt:1]) {
                
                [_hiHatSteps replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithInt:0]];
                
            }
            
        default:
            break;
    }

    [collectionView reloadData];

}

- (void) playSoundAtMarker:(NSTimer *)timer
{
    
    if ([_kickSteps objectAtIndex:markerPosition] == [NSNumber numberWithInt:1]) {
        [_drums playKick];
    }
    
    if ([_clapsSteps objectAtIndex:markerPosition] == [NSNumber numberWithInt:1]) {
        [_drums playClap];
    }
    
    if ([_snareSteps objectAtIndex:markerPosition] == [NSNumber numberWithInt:1]) {
       
        [_drums playSnare];
    }
    
    if ([_hiHatSteps objectAtIndex:markerPosition] == [NSNumber numberWithInt:1]) {
        [_drums playHats];
    }
    
    
    markerPosition++;
    
    if(markerPosition == totalSteps){
        
        markerPosition = 0;
        
        [UIView animateKeyframesWithDuration:0
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                                  animations:^{
                                      CGRect tempFrame = _markerView.frame;
                                      tempFrame.origin.x = 0;
                                      _markerView.frame = tempFrame;
                                  }
                                  completion:nil];
    } else {
        
        [UIView animateKeyframesWithDuration:0.2
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                                  animations:^{
                                      CGRect tempFrame = _markerView.frame;
                                      tempFrame.origin.x += 74;
                                      _markerView.frame = tempFrame;
                                  }
                                  completion:nil];

    }
    
}

- (void) dismissviewctrl {
    //currentMood = StepMoodClap;
    //[_stepSequencerCollectionView reloadData];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) layoutInstrumentButtons {
    
    UIButton *kickButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 150, 150)];
    kickButton.layer.cornerRadius = 75;
    kickButton.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    kickButton.tag = StepMoodKick;
    [kickButton addTarget:self action:@selector(handleInstrumentButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [kickButton setTitle:@"Kicks" forState:UIControlStateNormal];
    kickButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
    [self.view addSubview:kickButton];
    
    UIButton *clapsButton = [[UIButton alloc] initWithFrame:CGRectMake(350, 500, 150, 150)];
    clapsButton.layer.cornerRadius = 75;
    clapsButton.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    clapsButton.tag = StepMoodClap;
    [clapsButton addTarget:self action:@selector(handleInstrumentButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [clapsButton setTitle:@"Claps" forState:UIControlStateNormal];
    clapsButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
    [self.view addSubview:clapsButton];
    
    UIButton *snareButton = [[UIButton alloc] initWithFrame:CGRectMake(600, 500, 150, 150)];
    snareButton.layer.cornerRadius = 75;
    snareButton.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    snareButton.tag = StepMoodSnare;
    [snareButton addTarget:self action:@selector(handleInstrumentButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [snareButton setTitle:@"Snares" forState:UIControlStateNormal];
    snareButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
    [self.view addSubview:snareButton];
    
    UIButton *hiHatButton = [[UIButton alloc] initWithFrame:CGRectMake(850, 500, 150, 150)];
    hiHatButton.layer.cornerRadius = 75;
    hiHatButton.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    hiHatButton.tag = StepMoodHiHats;
    [hiHatButton addTarget:self action:@selector(handleInstrumentButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [hiHatButton setTitle:@"HiHats" forState:UIControlStateNormal];
    hiHatButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
    [self.view addSubview:hiHatButton];
    
}

- (void) handleInstrumentButtonTouch: (UIButton *) sender {

    switch (sender.tag) {
            
        case StepMoodKick:
            currentMood = StepMoodKick;
            break;
            
        case StepMoodClap:
            currentMood = StepMoodClap;
            break;
            
        case StepMoodSnare:
            currentMood = StepMoodSnare;
            break;
            
        case StepMoodHiHats:
            currentMood = StepMoodHiHats;
            break;
            
        default:
            
            break;
    }
    [_stepSequencerCollectionView reloadData];

}

- (CGFloat) window_height {
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

@end
