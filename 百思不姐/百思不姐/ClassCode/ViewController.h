//
//  ViewController.h
//  百思不姐
//
//  Created by MacBook on 16/8/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^talbeViewBlock)(NSString *strID);
@interface ViewController : UIViewController

@property (nonatomic, copy) void (^tableViewBlock)(NSString *strID);/** <#注释#> */

- (void)get:(void(^)(NSString *strID))block;


@end
