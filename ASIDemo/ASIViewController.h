//
//  ASIViewController.h
//  ASIDemo
//
//  Created by li yajie on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

@interface ASIViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIImageView *targetImage;
@property (retain, nonatomic) IBOutlet UIProgressView *mProgress;
@property (retain, nonatomic) IBOutlet UIButton *requestNetwork;

@property (retain, nonatomic) IBOutlet UILabel *resultProgress;
- (IBAction)startRequest:(id)sender;

@end
