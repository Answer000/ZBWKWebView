//
//  ZBWKWebView.m
//  ZBWKWebView
//
//  Created by 澳蜗科技 on 2017/3/21.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

#import "ZBWKWebView.h"

@interface ZBWKWebView()<WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;

@end

@implementation ZBWKWebView

#pragma mark-  初始化方法
+(instancetype)webView{
    return [[self alloc] init];
}

-(instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupViews];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

#pragma mark-  设置UI
-(void)setupViews{
    _isSameColorWithHeaderView = YES;
    _isSameColorWithHeaderView = YES;
}


-(void)setupHeaderViewForWebView:(WKWebView * _Nonnull)webView {
    if (_headerView) {
        UIEdgeInsets insets = UIEdgeInsetsZero;
        insets.top = _headerView.bounds.size.height;
        webView.scrollView.contentInset = insets;
        
        CGRect frame = _headerView.frame;
        frame.origin.y = -_headerView.bounds.size.height;
        _headerView.frame = frame;
        
        if (_isSameColorWithHeaderView){
            _headerView.backgroundColor = webView.scrollView.backgroundColor;
        }
        webView.scrollView.contentOffset = CGPointMake(0, -_headerView.bounds.size.height);
    }
}
-(void)setupFooterViewForWebView:(WKWebView * _Nonnull)webView {
    if (_headerView) [webView.scrollView addSubview:_headerView];
    if (_footerView) {
        __weak typeof(self) weakSelf = self;
        //延时1s操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf)  return;
            
            CGFloat footerViewHeight = strongSelf.footerView.bounds.size.height;
            NSString *js = [NSString stringWithFormat:@"\
                            var appendDiv = document.getElementById(\"AppAppendDIV\");\
                            if (appendDiv) {\
                            appendDiv.style.height = %@+\"px\";\
                            } else {\
                            var appendDiv = document.createElement(\"div\");\
                            appendDiv.setAttribute(\"id\",\"AppAppendDIV\");\
                            appendDiv.style.width=%@+\"px\";\
                            appendDiv.style.height=%@+\"px\";\
                            document.body.appendChild(appendDiv);\
                            }\
                            ", @(footerViewHeight),
                            @(webView.scrollView.contentSize.width),
                            @(footerViewHeight)];
            
            //调用js代码多留一块footerView高度的空白
            [webView evaluateJavaScript:js completionHandler:^(id _Nullable result,
                                                               NSError * _Nullable error) {
                //获取页面高度，并添加footerView
                [webView evaluateJavaScript:@"document.body.offsetHeight"
                          completionHandler:^(id _Nullable result,
                                              NSError * _Nullable error) {
                              
                              CGFloat webViewHeight = [result floatValue];
                              CGRect rect = strongSelf.footerView.frame;
                              rect.origin.y = webViewHeight - footerViewHeight;
                              strongSelf.footerView.frame = rect;
                              if (strongSelf.isSameColorWithFooterView) {
                                  strongSelf.footerView.backgroundColor = webView.scrollView.backgroundColor;
                              }
                              [webView.scrollView addSubview:strongSelf.footerView];
                }];
            }];
        });
    }
}

@end
