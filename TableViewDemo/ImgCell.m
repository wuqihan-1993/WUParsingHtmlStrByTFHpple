//
//  ImgCell.m
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "ImgCell.h"
#import "ContentModel.h"
#import <UIImageView+WebCache.h>

@interface ImgCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation ImgCell

+ (instancetype)imgCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"ImgCell" owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI:(ContentModel *)model {
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.text] placeholderImage:nil];
    self.bgImageView.bounds = CGRectMake(0, 0, model.imgWidth, model.imgHeight);
}
@end
