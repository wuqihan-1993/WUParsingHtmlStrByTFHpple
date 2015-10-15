//
//  ViewController.m
//  TableViewDemo
//
//  Created by wuqh on 15/10/15.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "ViewController.h"

#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "ContentModel.h"
#import "TextCell.h"
#import "ImgCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self parsingHtml];
    
}

- (void)parsingHtml {
    
   
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"File" ofType:nil];
//    NSString *htmlStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *htmlStr = @"<body><html><head></head><body><p><strong></strong>J·COFFEE，在小清新的外表下面，隐藏着浓浓的藏式风味的咖啡馆，独特又别致，让所有来过的人都耳目一新。</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141822.jpg\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141822.jpg\"></img><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141821.jpg\" height=\"465\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141821.jpg\" width=\"700\"></img></p><p>走进店里，就会感觉到西藏风格的装饰和摆设。店主常年旅行，最爱的地方就是青藏高原。所以，你能在店里看到随手写在柱子上的书法手迹，随处摆放的手串佛珠。</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141833.JPG\" height=\"428\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141833.JPG\" width=\"640\"></img><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141835.JPG\" height=\"956\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141835.JPG\" width=\"640\"></img><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141837.JPG\" height=\"428\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141837.JPG\" width=\"640\"></img></p><p>店内的风格朴实粗旷，却又不失温馨。大的原木桌子和各类沙发抱枕，让人又心生确定，这的确是一家咖啡馆。</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141836.JPG\" height=\"428\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141836.JPG\" width=\"640\"></img></p><p>店内还有一幅大大的墙画，画的是布达拉宫，店主已经把对西藏的爱淋漓尽致地表现在整个店的氛围中了。</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141828.JPG\" height=\"428\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141828.JPG\" width=\"640\"></img><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141827.jpg\" height=\"411\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141827.jpg\" width=\"700\"></img><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141825.jpg\" height=\"700\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141825.jpg\" width=\"525\"></img></p><p><strong></strong>店内的咖啡和简餐也深得客人的称道，味道好并且量足。坐在店内饮咖啡酒餐，看着周围空旷质朴的装饰，不由得让人想起那个远在千里的西藏来。咖啡香飘满在这个异域氛围的小馆内，令你我难以忘怀。</p><p><strong></strong><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141838.JPG\" height=\"428\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141838.JPG\" width=\"640\"></img><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-10-09/event141839.JPG\" height=\"428\" src=\"http://pic.huodongjia.com/event/2015-10-09/event141839.JPG\" width=\"640\"></img>​</p><p><strong>地址：</strong> 普陀区莫干山路99号(近M50艺术园区)</p><p><strong>营业时间：</strong> 10:30-20:00</p><p><strong>联系电话：</strong> 021-52951116</p></body></html></body>";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.dataArr = [self parseHtml:htmlStr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });

    
}

- (NSMutableArray *)parseHtml:(NSString *)htmlStr {
    NSMutableArray *dataArr = @[].mutableCopy;
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *array = [xpathParser searchWithXPathQuery:@"//p"];
    for (TFHppleElement *element in array) {
        if (element.children.count > 0) {
            for (TFHppleElement *subElement in element.children) {
                
                if ([subElement.tagName isEqualToString:@"strong"]) {
                    if (subElement.content.length > 0) {
                        ContentModel *model = [ContentModel new];
                        model.isImg = NO;
                        model.text = subElement.content;
                        [dataArr addObject:model];
                    }
                }
                if ([subElement.tagName isEqualToString:@"img"]) {
                    
                    
                    if (subElement.attributes[@"width"]) {
                        
                        
                        CGFloat height = [subElement.attributes[@"height"] floatValue];
                        CGFloat width = [subElement.attributes[@"width"] floatValue];
                        
                        ContentModel *model = [ContentModel new];
                        model.isImg = YES;
                        
                        model.imgHeight = height*model.imgWidth/width;
                        NSLog(@"%f",model.imgHeight);
                        model.text = subElement.attributes[@"src"];
                        
                        [dataArr addObject:model];
                    }
                }
            }
            
            if (element.content.length > 0) {
                ContentModel *model = [ContentModel new];
                model.isImg = NO;
                model.text = element.content;
                [dataArr addObject:model];
            }
        }else {
            ContentModel *model = [ContentModel new];
            model.isImg = NO;
            model.text = element.content;
            [dataArr addObject:model];
        }
        
    }
    return dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//#pragma mark - UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentModel *model = self.dataArr[indexPath.row];
    if (model.isImg) {
        static NSString *imgCellId = @"imgCell";
        ImgCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCellId];
        if (!cell) {
            cell = [ImgCell imgCell];
        }
        [cell updateUI:model];
        return cell;
        
    }else {
        static NSString *textCellId = @"textCell";
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellId];
        if (!cell) {
            cell = [TextCell textCell];
        }
        [cell updateUI:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentModel *model = self.dataArr[indexPath.row];
    if (model.isImg) {
        NSLog(@"%f %f",model.imgWidth,model.imgHeight);
        return model.imgHeight + 6;
    }else {
        NSMutableParagraphStyle *paragrahStype = [[NSMutableParagraphStyle alloc] init];
        paragrahStype.lineSpacing = 4;
        CGRect rect = [model.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-10, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:paragrahStype} context:nil];
        return rect.size.height+8;
    }
    return tableView.estimatedRowHeight;
    
}



@end
