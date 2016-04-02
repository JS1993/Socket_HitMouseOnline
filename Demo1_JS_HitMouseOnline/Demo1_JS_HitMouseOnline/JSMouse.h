//
//  JSMouse.h
//  Demo2_JS_PlayMouse
//
//  Created by  江苏 on 16/3/17.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "JSClientSocketViewController.h"
#import "JSServerSocketViewController.h"
@interface JSMouse : UIButton
@property(nonatomic,strong)JSServerSocketViewController* SeverSocketDelegate;
@property(nonatomic,strong)JSClientSocketViewController* ClientSocketDelegate;
@property(nonatomic,strong)UIViewController* delegate;
@end
