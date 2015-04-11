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
    
    switch (headerType) {
        case HeaderTypeKeyboard:
            _keyboardNotes = [[NSArray alloc]
                                  initWithObjects:@"B",@"A#",@"A",@"G#",@"G",@"F#",@"F",@"E",@"D#",@"D",@"C#",@"C",
                                  nil];
            break;
            
        case HeaderTypeDetailed:
            
            _keyboardNotes = [[NSArray alloc]
                              initWithObjects:@"Drums",@"Claps",@"Claps",@"Claps",@"Claps",@"Claps",@"Claps",@"Claps",@"Claps",@"Claps",@"Kick",@"Kick",
                              nil];
            
        default:
            break;
    }
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
    
    cell.contentView.backgroundColor = self.backgroundColor;
    cell.textLabel.textColor = [UIColor colorWithRed:0.122 green:0.157 blue:0.169 alpha:1];
    cell.textLabel.text = [_keyboardNotes objectAtIndex:[indexPath row]];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13];
    
    if ([indexPath row] % 12 < 6) {
        switch ([indexPath row] % 2) {
            case 0:
                cell.contentView.backgroundColor = self.backgroundColor;
                break;
            case 1:
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.141 green:0.184 blue:0.204 alpha:1];
                break;
            default:
                break;
        }
        
    } else if ([indexPath row] % 12 > 7) {
        
        switch ([indexPath row] % 2) {
            case 0:
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.141 green:0.184 blue:0.204 alpha:1];
                break;
            case 1:
                cell.contentView.backgroundColor = self.backgroundColor;
                
                break;
            default:
                break;
        }
        
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _totalNotes;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.frame.size.height/_totalNotes;
    
}


@end
