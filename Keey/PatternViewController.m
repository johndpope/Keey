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
    _addInstrumentBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_addInstrumentBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayContentController: (UICollectionViewController *) content;
{
    
    [self addChildViewController:content];
    content.view.frame = CGRectMake(0, ([self window_height]/6), [self window_width], 200);
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

    [UIView animateKeyframesWithDuration:0.5
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  content.view.backgroundColor = [UIColor colorWithRed:0.173 green:0.188 blue:0.188 alpha:0.8];

                              }
                              completion:^(BOOL finished) {
                                  // block fires when animaiton has finished
                              }];
}

- (void) addInstrument {
    _drawerViewController = [[DrawerViewController alloc] init];
    [self displayDrawerController:_drawerViewController];
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
