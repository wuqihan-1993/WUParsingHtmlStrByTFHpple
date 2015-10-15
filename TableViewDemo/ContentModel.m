//
//  ContentModel.m
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel

- (instancetype)init {
    if (self = [super init]) {
        self.imgWidth = [UIScreen mainScreen].bounds.size.width - 15;
    }
    return self;
}

@end
