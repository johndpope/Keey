//
//  InstrumentalHeaderView.h
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstrumentalHeaderView : UITableView <UITableViewDataSource, UITableViewDelegate>

typedef enum HeaderType : NSUInteger {
    
    HeaderTypeDetailed,
    HeaderTypeKeyboard
    
} HeaderType;

- (void) setUpHeaders: (int) headerCount withType: (HeaderType) headerType;

@property int totalNotes;

@end
