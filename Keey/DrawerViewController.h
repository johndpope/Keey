//
//  DrawerViewController.h
//  Keey
//
//  Created by Ipalibo Whyte on 14/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanelView.h"
#import "BubbleButton.h"

@class DrawerViewController;             //define class, so protocol can see MyClass
@protocol DrawerViewControllerDelegate <NSObject>   //define delegate protocol
- (void) DrawerViewControllerDelegateMethod: (DrawerViewController *) sender;  //define delegate method to be implemented within another class
@end //end protocol


@interface DrawerViewController : UIViewController {
    NSString *title;
}

@property (nonatomic, weak) id <DrawerViewControllerDelegate> delegate; //define MyClassDelegate as delegate
@property NSArray *drawerElements;
@property PanelView *panelView;
- (void) displayDrawerElements: ( NSArray *) elements;
- (void) animateDrawerIn;

@end
