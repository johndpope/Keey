//
//  PatternViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PatternViewController.h"

@interface PatternViewController ()

@end

@implementation PatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _patternCollectionCTRL = [[PatternCollectionViewCTRL alloc] initWithCollectionViewLayout:aFlowLayout];
    
    [self displayContentController:_patternCollectionCTRL];
    
    _addInstrumentBtn = [[BubbleButton alloc] initWithFrame:CGRectMake([self window_width]/2-50, 400, 100, 100)];
    [_addInstrumentBtn addTarget:self action:@selector(addInstrument) forControlEvents:UIControlEventTouchUpInside];
    [_addInstrumentBtn setSize:@"medium"];
    _addInstrumentBtn.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:1];
    [self.view addSubview:_addInstrumentBtn];
    
    
}

- (void) DrawerViewControllerDelegateMethod: (DrawerViewController *) sender {
    [self hideViewController:_drawerViewController];
}

- (void) displayContentController: (UICollectionViewController *) content;
{
    
    [self addChildViewController:content];
    content.view.frame = CGRectMake(20, ([self window_height]/6), [self window_width]-20, 300);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
    
}

- (void) displayDrawerController: (UIViewController*) content;
{
    
    content.view.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:0];

    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, 0, [self window_width], [self window_height]);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];

    [UIView animateKeyframesWithDuration:0.4
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  content.view.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:0.8];

                              }
                              completion:^(BOOL finished) {
                                  // block fires when animaiton has finished
                              }];
}

- (void) hideViewController: (UIViewController*) content
{
    [content willMoveToParentViewController:nil];  // 1
    [content.view removeFromSuperview];            // 2
    [content removeFromParentViewController];      // 3
}

- (void) createDrawerInstruments {
    
    InstrumentButton *drumBtn = [[InstrumentButton alloc] init];
    [drumBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [drumBtn ofType:InstrumentalTypeDrums ofSize:SmallSize];

    InstrumentButton *pianoBtn = [[InstrumentButton alloc] init];
    [pianoBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [pianoBtn ofType:InstrumentalTypePiano ofSize:SmallSize];

    InstrumentButton *trumpetBtn = [[InstrumentButton alloc] init];
    [trumpetBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [trumpetBtn ofType:InstrumentalTypeTrumpet ofSize:SmallSize];
    
    InstrumentButton *guitarBtn = [[InstrumentButton alloc] init];
    [guitarBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [guitarBtn ofType:InstrumentalTypeGuitar ofSize:SmallSize];
    
    InstrumentButton *fluteBtn = [[InstrumentButton alloc] init];
    [fluteBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [fluteBtn ofType:InstrumentalTypeFlute ofSize:SmallSize];
    
    InstrumentButton *synthBtn = [[InstrumentButton alloc] init];
    [synthBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [synthBtn ofType:InstrumentalTypeSynth ofSize:SmallSize];
    
    InstrumentButton *voxBtn = [[InstrumentButton alloc] init];
    [voxBtn addTarget:self action:@selector(addInstrumentToPatternScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [voxBtn ofType:InstrumentalTypeVox ofSize:SmallSize];
    
    _instrumentFactory = [[NSArray alloc] initWithObjects:drumBtn,pianoBtn,trumpetBtn,guitarBtn,fluteBtn,synthBtn,voxBtn, nil];
    
    [_drawerViewController displayDrawerElements:_instrumentFactory];


}


- (void) addInstrumentToPatternScrollView : (InstrumentButton *) sender {
    
    [_patternCollectionCTRL addPatternInstrument:sender];
}

- (void) OverLayDidTap: (UITapGestureRecognizer*) sender {
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

- (void) addInstrument {
    
    _drawerViewController = [[DrawerViewController alloc] init];
    [_drawerViewController setDelegate:self];
    [self displayDrawerController:_drawerViewController];
    
    [self createDrawerInstruments];

    //[_patternCollectionCTRL addPatternInstrument:(NSObject *)@"drums"];
}

- (CGFloat) window_height {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

- (CGFloat) window_width {
    return [UIScreen mainScreen].applicationFrame.size.width;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
