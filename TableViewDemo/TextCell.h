//
//  TextCell.h
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentModel;
@interface TextCell : UITableViewCell

+ (instancetype)textCell;

- (void)updateUI:(ContentModel*)model;

@end
