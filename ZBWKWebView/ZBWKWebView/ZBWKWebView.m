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

#pragma mark-  懒加载
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark-  初始化方法
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupViews];
}
+(instancetype)webView{
    return [[self alloc] init];
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
    [self addSubview:self.webView];
    _isSameColorWithHeaderView = YES;
    _isSameColorWithHeaderView = YES;
}

#pragma mark-  重写系统布局方法
-(void)layoutSubviews{
    [super layoutSubviews];
    //布局
    self.webView.frame = self.bounds;
}

-(WKNavigation *)loadRequest:(NSURLRequest *)request{
    return [self.webView loadRequest:request];
}

-(WKNavigation *)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{
    return [self.webView loadHTMLString:string baseURL:baseURL];
}

#pragma mark-  WKNavigationDelegate
//页面开始加载时调用
- (void)webView:(WKWebView * _Nonnull)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView didStartProvisionalNavigation:navigation];
    }
    if (_headerView) {
        webView.scrollView.contentInset = UIEdgeInsetsMake(_headerView.bounds.size.height, 0, 0, 0);
        CGRect frame = _headerView.frame;
        frame.origin.y = -_headerView.bounds.size.height;
        _headerView.frame = frame;
        if (_isSameColorWithHeaderView) _headerView.backgroundColor = webView.scrollView.backgroundColor;
        [webView.scrollView addSubview:_headerView];
        webView.scrollView.contentOffset = CGPointMake(0, -_headerView.bounds.size.height);
    }
}
//页面完成加载时调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView didFinishNavigation:navigation];
    }
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
                            ", @(footerViewHeight), @(webView.scrollView.contentSize.width), @(footerViewHeight)];
            //调用js代码多留一块footerView高度的空白
            [webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {

                //获取页面高度，并添加footerView
                [webView evaluateJavaScript:@"document.body.offsetHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error) {
                    CGFloat webViewHeight = [result floatValue];
                    CGRect rect = strongSelf.footerView.frame;
                    rect.origin.y = webViewHeight - footerViewHeight;
                    strongSelf.footerView.frame = rect;
                    if (strongSelf.isSameColorWithFooterView) strongSelf.footerView.backgroundColor = webView.scrollView.backgroundColor;
                    [webView.scrollView addSubview:strongSelf.footerView];
                }];
            }];
        });
    }
}
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView * _Nonnull )webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction decisionHandler:(void (^) (WKNavigationActionPolicy))decisionHandler{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView: decidePolicyForNavigationAction: decisionHandler:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView     decidePolicyForNavigationAction:navigationAction decisionHandler:(void (^) (ZBWKNavigationActionPolicy))decisionHandler];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
//当客户端收到服务器的响应头，可根据navigationResponse相关信息决定是否继续跳转
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:(void (^)(ZBWKNavigationResponsePolicy))decisionHandler];
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView * _Nonnull)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView: didReceiveServerRedirectForProvisionalNavigation:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}
//页面加载失败时调用
- (void)webView:(WKWebView * _Nonnull)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView didFailProvisionalNavigation:navigation withError:error];
    }
}
//页面开始返回内容时调用
- (void)webView:(WKWebView * _Nonnull)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    if ([_wkNavigationDelegate respondsToSelector:@selector(webView: didCommitNavigation:)]) {
        [_wkNavigationDelegate webView:(ZBWKWebView *)webView didCommitNavigation:navigation];
    }
}

@end
