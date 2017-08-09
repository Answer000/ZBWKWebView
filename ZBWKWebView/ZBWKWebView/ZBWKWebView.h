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

@interface ZBWKWebView : WKWebView

/** 在代理方法 (webView: didStartProvisionalNavigation:) 优先中调用 */
-(void)setupHeaderViewForWebView:(ZBWKWebView * _Nonnull)webView;

/** 在代理方法 (webView: didFinishNavigation:) 优先中调用 */
-(void)setupFooterViewForWebView:(ZBWKWebView * _Nonnull)webView;

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
