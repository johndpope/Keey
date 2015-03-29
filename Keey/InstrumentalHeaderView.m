//
//  InstrumentalHeaderView.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "InstrumentalHeaderView.h"

@implementation InstrumentalHeaderView

- (void) setUpHeaders: (int) headerCount withType:(HeaderType)headerType {
    [self setDelegate:self];
    [self setDataSource:self];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollEnabled = NO;
    self.backgroundColor = [UIColor colorWithRed:0.18 green:0.224 blue:0.247 alpha:1];


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:0.122 green:0.157 blue:0.169 alpha:1];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
    
    if ([indexPath row] % 12 < 6) {
        switch ([indexPath row] % 2) {
            case 0:
                cell.backgroundColor = [UIColor clearColor];
                break;
            case 1:
                cell.backgroundColor = [UIColor colorWithRed:0.141 green:0.184 blue:0.204 alpha:1];
                break;
            default:
                break;
        }
        
    } else if ([indexPath row] % 12 > 7) {
        
        switch ([indexPath row] % 2) {
            case 0:
                cell.backgroundColor = [UIColor colorWithRed:0.141 green:0.184 blue:0.204 alpha:1];
                break;
            case 1:
                cell.backgroundColor = [UIColor clearColor];
                
                break;
            default:
                break;
        }
        
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.frame.size.height/12;
    
}


@end
