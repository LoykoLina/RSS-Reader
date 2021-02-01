//
//  RSSRWebBrowserController.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/13/20.
//

#import "RSSRWebBrowserController.h"
#import <WebKit/WebKit.h>
#import "UIImage+RSSRImage.h"

@interface RSSRWebBrowserController () <WKNavigationDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet WKWebView *webView;
@property (retain, nonatomic) UIBarButtonItem *backButton;
@property (retain, nonatomic) UIBarButtonItem *forwardButton;
@property (retain, nonatomic) UIBarButtonItem *reloadButton;
@property (retain, nonatomic) UIBarButtonItem *stopButton;

@property (copy, nonatomic) NSURLRequest *request;
@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation RSSRWebBrowserController


#pragma mark - Lazy properties

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        _backButton = [[UIBarButtonItem alloc] initWithImage:UIImage.RSSRBack
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(previousPage)];
    }
    return _backButton;
}

- (UIBarButtonItem *)forwardButton {
    if (!_forwardButton) {
        _forwardButton = [[UIBarButtonItem alloc] initWithImage:UIImage.RSSRNext
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(nextPage)];
    }
    return _forwardButton;
}

- (UIBarButtonItem *)stopButton {
    if (!_stopButton) {
        _stopButton = [[UIBarButtonItem alloc] initWithImage:UIImage.RSSRStop
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(stopLoading)];
    }
    return _stopButton;
}

- (UIBarButtonItem *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [[UIBarButtonItem alloc] initWithImage:UIImage.RSSRReload
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(reloadPage)];
    }
    return _reloadButton;
}


#pragma mark - Initialization & Deallocation

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    self = [super init];
    if (self) {
        _request = [request retain];
    }
    return self;
}

- (void)dealloc {
    [_webView release];
    [_request release];
    [_backButton release];
    [_forwardButton release];
    [_reloadButton release];
    [_stopButton release];
    [super dealloc];
}


#pragma mark - View controller life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    
    [self configureNavigationController];
    [self configureToolbarItems];
    [self disableControlButtons];
    
    self.webView.scrollView.delegate = self;
    self.webView.navigationDelegate = self;

    [self startLoading];
}



- (void)configureToolbarItems {
    UIBarButtonItem *safariButton = [[UIBarButtonItem alloc] initWithImage:UIImage.RSSRExplore
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(openInSafari)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    
    [self setToolbarItems:@[self.backButton, flexibleSpace, self.forwardButton, flexibleSpace, self.reloadButton, flexibleSpace, self.stopButton, flexibleSpace, safariButton]];
    
    [safariButton release];
    [flexibleSpace release];
}

- (void)configureNavigationController {
    [self.navigationController setHidesBarsOnSwipe:NO];
    [self.navigationController setToolbarHidden:NO];
    self.navigationItem.title = [NSURL URLWithString:self.request.URL.absoluteString].host;
    
    UIBarButtonItem *doneBackButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(popViewController)];
    self.navigationItem.leftBarButtonItem = doneBackButton;
    [doneBackButton release];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startLoading {
    [self.webView loadRequest:self.request];
}

- (void)disableControlButtons {
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    self.stopButton.enabled = NO;
    self.reloadButton.enabled = NO;
}


#pragma mark - Hide/show toolbar and navigationbar

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= self.lastContentOffset) {
        [self.navigationController setToolbarHidden:NO animated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [self.navigationController setToolbarHidden:YES animated:YES];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    self.backButton.enabled = [self.webView canGoBack] ? YES : NO;
    self.forwardButton.enabled = [self.webView canGoForward] ? YES : NO;
    self.stopButton.enabled = YES;
    self.reloadButton.enabled = NO;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.stopButton.enabled = NO;
    self.reloadButton.enabled = YES;
}


#pragma mark - Toolbar buttons actions

- (void)openInSafari {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.request.URL.absoluteString]
                                       options:@{}
                             completionHandler:nil];
}

- (void)stopLoading {
    [self.webView stopLoading];
    self.stopButton.enabled = NO;
    self.reloadButton.enabled = YES;
}

- (void)reloadPage {
    [self.webView reloadFromOrigin];
}

- (void)nextPage {
    [self.webView goForward];
}

- (void)previousPage {
    [self.webView goBack];
}

@end
