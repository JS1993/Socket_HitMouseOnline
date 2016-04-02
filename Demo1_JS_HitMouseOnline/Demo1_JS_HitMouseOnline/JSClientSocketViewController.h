//
//  JSClientSocketViewController.h
//  Demo1_JS_HitMouseOnline
//
//  Created by  江苏 on 16/3/27.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSClientSocketViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *deadMouse;
@property (strong, nonatomic) IBOutlet UILabel *escapeMouse;
-(void)seccuss;
-(void)failed;
@end
