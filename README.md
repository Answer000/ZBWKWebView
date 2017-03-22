# ZBWKWebView

[![star this repo](http://githubbadges.com/star.svg?user=AnswerXu&repo=ZBWKWebView&style=flat&color=bbb&background=007ecg)](https://github.com/AnswerXu/ZBWKWebView.git)&nbsp;&nbsp;[![fork this repo](http://githubbadges.com/fork.svg?user=AnswerXu&repo=ZBWKWebView&style=flat&color=bbb&background=007ecg)](https://github.com/AnswerXu/ZBWKWebView/fork)

- 项目中我们会经常有加载网页的需求，所以UIWebView或者是WKWebView就是不可或缺的开发控件。iOS8以前用的是UIWebView，但是用过的同学就会发现UIWebView占用的内存较多，达到峰值时更是夸张。iOS8以后苹果推出了一个新的控件——WKWebView。据官方介绍，WKWebView的性能优化较UIWebView而言提高了数倍，查看内存占用率确实比UIWebView降低了不少。虽然WKWebView也有不少的缺点，但是与UIWebView过高占用内存相比，开发者们更愿意选择WKWebView。所以，随着iOS7的淘汰，WKWebView替换UIWebView成为了一种趋势。

- 开发中可能会有添加头部视图或尾部视图的需求，但是我们并不能像UITableView和UICollectionView那样便捷的添加头视图或尾视图。

## 效果图
![image](https://github.com/AnswerXu/ZBWKWebView/blob/master/ReadImage/2017-03-21%2019_15_34.gif)


## Usage
  - 在文件中引入头文件：#import "ZBWKWebView.h"
  - 如需要使用WKNavigationDelegate代理，请使用ZBWKNavigationDelegate设置代理。如果使用WKNavigationDelegate设置代理，则会覆盖之前设置的代理对象，无法添加头部或尾部视图。
* 设置headerView
```Objc
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor redColor];
    UIGraphicsBeginImageContextWithOptions(headerView.bounds.size, NO, 0);
    [headerView drawRect:headerView.bounds];
    NSString *headerStr = @"I am headerView";
    [headerStr drawAtPoint:CGPointMake(10, headerView.bounds.size.height * 0.5 - 30) withAttributes:@{NSFontAttributeName : [UIFont italicSystemFontOfSize:45], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIImage *headerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    headerView.image = headerImage;
    
    //是否设置自定义headerView的背景色与WKWebView一致
    _webView.isSameColorWithHeaderView = NO;
    //设置头部视图
    _webView.headerView = headerView;
```

* 设置footerView
```Objc
    UIImageView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    footerView.backgroundColor = [UIColor yellowColor];
    UIGraphicsBeginImageContextWithOptions(footerView.bounds.size, NO, 0);
    [footerView drawRect:footerView.bounds];
    NSString *headerStr = @"I am footerView";
    [headerStr drawAtPoint:CGPointMake(20, footerView.bounds.size.height * 0.5 - 30) withAttributes:@{NSFontAttributeName :           [UIFont italicSystemFontOfSize:45], NSForegroundColorAttributeName : [UIColor redColor]}];
    UIImage *headerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    footerView.image = headerImage;
    
    //是否设置自定义footerView的背景色与WKWebView一致
    _webView.isSameColorWithFooterView = NO;
    //设置尾部视图
    _webView.footerView = footerView;
```
     
  - [参考](http://m.blog.csdn.net/article/details?id=53352516)
  - 谢谢支持，可能还有很多不完善的地方，期待您的建议！如对您有帮助，请不吝您的Star，您的支持与鼓励是我继续前行的动力。邮箱：zhengbo073017@163.com
