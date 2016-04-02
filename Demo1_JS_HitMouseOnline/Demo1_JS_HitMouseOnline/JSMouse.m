//
//  JSMouse.m
//  Demo2_JS_PlayMouse
//
//  Created by  江苏 on 16/3/17.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSMouse.h"

@implementation JSMouse

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor redColor];
        self.layer.cornerRadius=4;
        self.layer.masksToBounds=YES;
        [self setTitle:@"3" forState:UIControlStateNormal];
        [NSThread detachNewThreadSelector:@selector(countDownAction) toTarget:self withObject:nil];
        [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)countDownAction{
    for (int i=0; i<3; i++) {
        [NSThread sleepForTimeInterval:1];
        if (!self.superview) {
            return;
        }
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
    }
}
-(void)updateUI{
    int time=[[self titleForState:UIControlStateNormal] intValue];
    [self setTitle:[NSString stringWithFormat:@"%d",time-1] forState:UIControlStateNormal];
    if (time==1) {
        [self.SeverSocketDelegate failed];
        [self.ClientSocketDelegate failed];
        [self removeFromSuperview];
    }
}
-(void)clicked{
    [self.SeverSocketDelegate seccuss];
    [self.ClientSocketDelegate seccuss];
    [self removeFromSuperview];
}
@end
