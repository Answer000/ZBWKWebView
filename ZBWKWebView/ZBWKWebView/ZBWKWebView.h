//
//  ZBWKWebView.h
//  ZBWKWebView
//
//  Created by 澳蜗科技 on 2017/3/21.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class ZBWKWebView;

typedef NS_ENUM(NSInteger, ZBWKNavigationActionPolicy) {
    NavigationActionPolicyCancel,
    NavigationActionPolicyAllow,
} API_AVAILABLE(macosx(10.10), ios(8.0));

typedef NS_ENUM(NSInteger, ZBWKNavigationResponsePolicy) {
    NavigationResponsePolicyCancel,
    NavigationResponsePolicyAllow,
} API_AVAILABLE(macosx(10.10), ios(8.0));

@protocol ZBWKNavigationDelegate <NSObject>
@optional
/** //在发送请求之前，决定是否跳转 */
- (void)webView:( ZBWKWebView * _Nonnull )webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction decisionHandler:(void (^ _Nonnull) (ZBWKNavigationActionPolicy))decisionHandler;

/** 当客户端收到服务器的响应头，可根据navigationResponse相关信息决定是否继续跳转 */
- (void)webView:(ZBWKWebView * _Nonnull)webView decidePolicyForNavigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse decisionHandler:(void (^ _Nonnull)(ZBWKNavigationResponsePolicy))decisionHandler;

/** 开始加载时调用 */
- (void)webView:(ZBWKWebView * _Nonnull)webView didStartProvisionalNavigation:(WKNavigation * _Nonnull)navigation;

/** 接收到服务器跳转请求之后调用 */
- (void)webView:(ZBWKWebView * _Nonnull)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

/** 加载失败时调用 */
- (void)webView:(ZBWKWebView * _Nonnull)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(null_unspecified NSError *)error;

/** 开始返回内容时调用 */
- (void)webView:(ZBWKWebView * _Nonnull)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

/** 加载完成时调用 */
- (void)webView:(ZBWKWebView * _Nonnull)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
@end


@interface ZBWKWebView : WKWebView

/** ZBWKNavigationDelegate */
@property (nullable, nonatomic, weak) id <ZBWKNavigationDelegate> wkNavigationDelegate;

/** headerView */
@property (nonatomic) UIView *_Null_unspecified headerView;

/** footerView */
@property (nonatomic) UIView *_Null_unspecified footerView;

/** 是否设置headerView的背景色与webView一致(默认：YES) */
@property (nonatomic,assign) BOOL isSameColorWithHeaderView;

/** 是否设置footerView的背景色与webView一致(默认：YES) */
@property (nonatomic,assign) BOOL isSameColorWithFooterView;


/** 实例方法(类方法) */
/* 或init, initWithFrame:, xib */
+(instancetype _Nullable)webView;

@end
