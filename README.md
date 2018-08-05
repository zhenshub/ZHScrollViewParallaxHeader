# ZHScrollViewParallaxHeader
A Parallax effect for scrollView. you can setup a property and easy use Parallax effect

##### Usage:

```
	self.tableView.parallaxHeader.height = 200.f;
    self.tableView.parallaxHeader.delegate = self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stars"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.parallaxHeader.contentView = imageView;
```
<img src="./parallaxEffect.gif" width="375" height="667" />

##### You can implement Protocol <ZHParallaxHeaderDelegate>
```
- (void)parallaxHeaderDidScroll:(ZHParallaxHeader *)parallaxHeader {
    
    NSLog(@"CGFloat:%lf", parallaxHeader.progress);
    
    CGFloat threshold = 0.6;
    CGFloat progress = parallaxHeader.progress;
    if (progress > threshold) {
        self.naviBar.alpha = 0;
        return;
    }
    
    // to control the fake navigation bar alpha 
    self.naviBar.alpha = 1 - parallaxHeader.progress / threshold;
}
```

| 联系方式 |  |
|---------|----|
|QQ|2536093279|
|email|mail.fangzheng@gmail.com|
> feedback: 
> QQ:2536093279
> 