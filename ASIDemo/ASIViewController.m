//
//  ASIViewController.m
//  ASIDemo
//
//  Created by li yajie on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ASIViewController.h"

@interface ASIViewController ()

@end

@implementation ASIViewController
@synthesize targetImage;
@synthesize mProgress;
@synthesize requestNetwork;
@synthesize resultProgress;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTargetImage:nil];
    [self setMProgress:nil];
    [self setRequestNetwork:nil];
    [self setResultProgress:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [targetImage release];
    [mProgress release];
    [requestNetwork release];
    [resultProgress release];
    [super dealloc];
}

- (IBAction)startRequest:(id)sender {
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"网络当前不可用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
//        [alertView show];
//        [alertView release];
        NSURL * url = [NSURL URLWithString:@"http://img.evolife.cn/2011-07/ad1e1823f6c67c75.jpg"];
        ASIHTTPRequest *httpRequest = [[ASIHTTPRequest alloc] initWithURL:url];
        //创建进度条页面
        MBProgressHUD *progress = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
        [progress setMode:MBProgressHUDModeIndeterminate];
        progress.taskInProgress = YES;
        [self.view addSubview:progress];
        [progress show:YES];
        //加载图片请求
        [httpRequest setCompletionBlock:^{
            [progress hide:YES];
            targetImage.image = [UIImage imageWithData:[httpRequest responseData]];
            mProgress.hidden = YES;
            
        }];
        
        static long long downloaded = 0;
        [httpRequest setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
            downloaded += size;
           CGFloat percent = (CGFloat)downloaded / total;
            mProgress.progress = percent;
            resultProgress.text = [NSString stringWithFormat:@"%.0f%%",percent * 100];
        }];
        
        [httpRequest startAsynchronous];
        
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"网络当前不可用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
        [alertView show];
        [alertView release];
    }
}
@end
