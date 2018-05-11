//
//  FTDWebViewController.m
//  ForceTouchDemo
//
//  Created by zesming on 2018/5/8.
//  Copyright © 2018年 ming.cn. All rights reserved.
//

#import "FTDWebViewController.h"

#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>

@interface FTDWebViewController () <WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation FTDWebViewController

- (void)loadView {
    [super loadView];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.webView.UIDelegate = self;
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://jdc.jd.com/demo/3d-touch/"];
//    NSURL *url = [NSURL URLWithString:@"https://apple.com/cn"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
