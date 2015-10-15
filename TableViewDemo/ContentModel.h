//
//  ContentModel.h
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ContentModel : NSObject

@property (nonatomic, assign) BOOL isImg;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, assign) CGFloat textHeight;

@end
