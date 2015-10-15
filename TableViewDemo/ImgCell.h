//
//  ImgCell.h
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentModel;
@interface ImgCell : UITableViewCell

+ (instancetype)imgCell;
- (void)updateUI:(ContentModel *)model;

@end
