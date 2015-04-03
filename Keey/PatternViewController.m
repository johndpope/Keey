//
//  PatternViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 11/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#import "PatternViewController.h"
#import "TLSpringFlowLayout.h"
#import <pop/POP.h>

@interface PatternViewController ()

@end

@implementation PatternViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    TLSpringFlowLayout *aFlowLayout = [[TLSpringFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _patternCollectionCTRL = [[PatternCollectionViewCTRL alloc] initWithCollectionViewLayout:aFlowLayout];
    
    [self displayContentController:_patternCollectionCTRL];
    
    _addInstrumentBtn = [[BubbleButton alloc] initWithFrame:CGRectMake([self window_width]/2-50, 400, 100, 100)];
    [_addInstrumentBtn addTarget:self action:@selector(addInstrument) forControlEvents:UIControlEventTouchUpInside];
    [_addInstrumentBtn setSize:@"medium"];
    _addInstrumentBtn.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_addInstrumentBtn.frame.size.width/2-15, _addInstrumentBtn.frame.size.height/2-15, 30, 30)];
    imageView.image = [UIImage imageNamed:@"addicon.png"];
    [_addInstrumentBtn addSubview:imageView];
    
    [self.view addSubview:_addInstrumentBtn];
    
}

- (void) closeDrawerController: (DrawerViewController *) sender {
    [self hideDrawerController:_drawerViewController];
}

- (void) displayContentController: (UICollectionViewController *) content {
    
    [self addChildViewController:content];
    content.view.frame = CGRectMake(20, ([self window_height]/6), [self window_width]-20, 300);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
    
}

- (void) displayDrawerController: (DrawerViewController*) content {
    
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, -120, [self window_width], [self window_height]+120);
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anim.fromValue = [UIColor colorWithRed:0.133 green:0.192 blue:0.212 alpha:0];
    anim.toValue = [UIColor colorWithRed:0.133 green:0.192 blue:0.212 alpha:0.8];
    anim.springSpeed = 30;
    anim.springBounciness = 0;
    anim.removedOnCompletion = YES;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        [content animateDrawerIn];
        
    };
    
    [content.view pop_addAnimation:anim forKey:@"springAnimation"];

}

- (void) hideDrawerController: (DrawerViewController*) drawerViewCtrl {
    
    [(DrawerViewController *)drawerViewCtrl animateDrawerOut:^(BOOL finished){
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
        anim.toValue = [UIColor colorWithRed:0.133 green:0.192 blue:0.212 alpha:0];
        anim.springSpeed = 30;
        anim.springBounciness = 0;
        anim.removedOnCompletion = YES;
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
            
            [self hideViewController:drawerViewCtrl];
            
        };
        
        [drawerViewCtrl.view pop_addAnimation:anim forKey:@"springAnimation"];
        
    }];

}

- (void) hideViewController: (UIViewController*) content {
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
    return SCREEN_HEIGHT;
}

- (CGFloat) window_width {
    return SCREEN_WIDTH;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *) getAllPatternsButtons {
    
    return _patternCollectionCTRL.patternInstruments;
}

- (NSMutableArray *) getAllCurrentPatternControllers {
    
    return _patternCollectionCTRL.currentPatterns;
}

@end
