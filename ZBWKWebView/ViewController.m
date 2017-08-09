//
//  ViewController.m
//  ZBWKWebView
//
//  Created by 澳蜗科技 on 2017/3/21.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

#import "ViewController.h"
#import "ZBWKWebView.h"

@interface ViewController ()<UIScrollViewDelegate, WKNavigationDelegate>
@property (nonatomic,weak) ZBWKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZBWKWebView *webView = [ZBWKWebView webView];
    webView.frame = self.view.bounds;
    webView.scrollView.delegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    _webView = webView;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/AnswerXu"]]];
    
    [self makeHeaderView];
    [self makeFooterView];
}

-(void)makeHeaderView{
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor redColor];
    
    UIGraphicsBeginImageContextWithOptions(headerView.bounds.size, NO, 0);
    [headerView drawRect:headerView.bounds];
    
    NSString *headerStr = @"I am headerView";
    [headerStr drawAtPoint:CGPointMake(10, headerView.bounds.size.height * 0.5 - 30) withAttributes:@{NSFontAttributeName : [UIFont italicSystemFontOfSize:45], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIImage *headerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    headerView.image = headerImage;
    
    _webView.isSameColorWithHeaderView = NO;
    _webView.headerView = headerView;
}

-(void)makeFooterView{
    UIImageView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    footerView.backgroundColor = [UIColor yellowColor];
    
    UIGraphicsBeginImageContextWithOptions(footerView.bounds.size, NO, 0);
    [footerView drawRect:footerView.bounds];
    
    NSString *headerStr = @"I am footerView";
    [headerStr drawAtPoint:CGPointMake(20, footerView.bounds.size.height * 0.5 - 30) withAttributes:@{NSFontAttributeName : [UIFont italicSystemFontOfSize:45], NSForegroundColorAttributeName : [UIColor redColor]}];
    
    UIImage *headerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    footerView.image = headerImage;

    _webView.isSameColorWithFooterView = NO;
    _webView.footerView = footerView;
}

#pragma mark-  WKNavigationDelegate
//页面开始加载时调用
- (void)webView:(WKWebView * _Nonnull)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [_webView setupHeaderViewForWebView:(ZBWKWebView *)webView];
}
//页面完成加载时调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [_webView setupFooterViewForWebView:(ZBWKWebView *)webView];
}


#pragma mark-  UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
}


@end
