# PullDownBlur
下拉tableVIew，头视图变模糊。
模仿"闲鱼"同城模块下拉模糊效果。
主要代码：
```Objective-c
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

```
效果如下:
![](https://github.com/CoderJee/PullDownBlur/blob/master/CoderJeeBlur.gif)
