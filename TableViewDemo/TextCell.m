//
//  TextCell.m
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "TextCell.h"
#import "ContentModel.h"
@interface TextCell()


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation TextCell

+ (instancetype)textCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"TextCell" owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel.numberOfLines = 0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUI:(ContentModel *)model {

    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:model.text];
    NSMutableParagraphStyle *praragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [praragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:praragraphStyle range:NSMakeRange(0, model.text.length)];
    self.contentLabel.attributedText = attributedString;
    [self.contentLabel sizeToFit];;
    
}

@end



