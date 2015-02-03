//
//  CJTableViewController.m
//  闲鱼同城模块
//
//  Created by CoderJee on 15/2/2.
//  Copyright (c) 2015年 CoderJee. All rights reserved.
//

#import "CJTableViewController.h"
#import "UIView+Extension.h"
#import "UIImage+DDF.h"
@interface CJTableViewController ()
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)UIImageView *imgView;
@property (nonatomic, assign)CGRect imgRect;
@property (nonatomic, assign)CGFloat previousY;
@property (nonatomic, weak)UIView *cover;
@property (nonatomic, strong)UIImage *mainImage;
@property (nonatomic, weak)UILabel *desLabel;
@end

@implementation CJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    
    // 初始化图片
    UIImage *image = [UIImage imageNamed:@"CoderJee.jpg"];
    self.mainImage = image;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, -image.size.height * 0.25, self.view.width, image.size.height * 0.25)];
    self.cover = headView;
    headView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"北京\tBeijing";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:30];
    label.size = CGSizeMake(200, 70);
    label.centerX = headView.centerX;
    label.y = 20;
    [headView addSubview:label];
    
    UILabel *desLabel = [[UILabel alloc] init];
    self.desLabel = desLabel;
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.text = @"摩擦，摩擦。。。";
    desLabel.textColor = [UIColor blackColor];
    desLabel.size = CGSizeMake(200, 70);
    desLabel.centerX = headView.centerX;
    desLabel.y = 70;
    [headView addSubview:desLabel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -image.size.height * 0.25, 320, image.size.height * 0.25 )];
    self.imgView  =imgView;
    // 保存原始的frame
    self.imgRect = imgView.frame;
    imgView.image = image;
    imgView.clipsToBounds = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.layer.masksToBounds = YES;
    
    [self.tableView insertSubview:imgView atIndex:0];
    [self.tableView insertSubview:headView aboveSubview:imgView];
    // 记录上一次的previousY
    self.previousY = -imgView.size.height - 64;
    self.tableView.contentInset = UIEdgeInsetsMake(imgView.height + 64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CJ"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CJ"];
    }
    cell.textLabel.text = @"CoderJee";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 往上下滚动
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    //NSLog(@"%f  --  %f", contentOffsetY, self.imgRect.size.height + 64);
    if(contentOffsetY <= -self.imgRect.size.height - 64){
        
        if (self.imgView.y > - self.imgRect.size.height) {
            self.imgView.y =  - self.imgRect.size.height;
            self.cover.y = self.imgView.y;
            self.previousY = -self.imgRect.size.height - 64;
        }
        
        CGFloat sss = (self.previousY - contentOffsetY);
        self.imgView.y  -= sss;
        self.imgView.height +=  sss ;
        
        self.cover.y -= sss;
        self.cover.height += sss;
        
        NSData *imageData = UIImageJPEGRepresentation(self.mainImage, 0);
        UIImage *image = [UIImage imageWithData:imageData];
        float blurValue = self.tableView.contentOffset.y + (self.imgRect.size.height + 64);
        self.desLabel.alpha = -blurValue / 100;
        self.imgView.image = [UIImage blurryImage:image withBlurLevel:0.1001];
        self.previousY = contentOffsetY;
        if (contentOffsetY == -self.imgRect.size.height - 64) {
            self.imgView.image = self.mainImage;
        }
    }
}




@end
