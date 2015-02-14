//
//  SplashPageViewController.m
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "SplashPageViewController.h"

@interface SplashPageViewController ()

@end

@implementation SplashPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.145 green:0.169 blue:0.192 alpha:1];
    
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 150, 320, 320)];
    logoLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    logoLabel.text = @"Keey";
    logoLabel.font = [UIFont systemFontOfSize:50];
    [self.view addSubview:logoLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
