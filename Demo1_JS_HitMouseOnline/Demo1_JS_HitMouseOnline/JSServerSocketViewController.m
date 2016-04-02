//
//  JSServerSocketViewController.m
//  Demo1_JS_HitMouseOnline
//
//  Created by  江苏 on 16/3/27.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSServerSocketViewController.h"
#import "AsyncSocket.h"
#import "JSMouse.h"
@interface JSServerSocketViewController ()<AsyncSocketDelegate>
@property(nonatomic,strong)AsyncSocket* mySeverSocket;
@property(nonatomic,strong)AsyncSocket* myNewScoket;
@property (strong, nonatomic) IBOutlet UILabel *connectionStaus;
@property(nonatomic)float showX;
@property(nonatomic)float showY;
@end

@implementation JSServerSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mySeverSocket=[[AsyncSocket alloc]initWithDelegate:self];
    [self.mySeverSocket acceptOnPort:8000 error:nil];
}
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    self.myNewScoket=newSocket;
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    self.connectionStaus.text = @"连接成功";
    [self.myNewScoket readDataWithTimeout:-1 tag:0];
}
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
//    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//    NSValue *v = [unArch decodeObjectForKey:@"point"];
//    CGPoint p = [v CGPointValue];
//    [self addMouse:p];
//    [self.myNewScoket readDataWithTimeout:-1 tag:0];
    NSString *info  = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray* points=[info componentsSeparatedByString:@"&&"];
    self.showX=[points[0] intValue];
    self.showY=[points[1] intValue];
    [sock readDataWithTimeout:-1 tag:0];
    CGPoint point=CGPointMake(self.showX, self.showY);
    NSLog(@"%f,%f",point.x,point.y);
    [self addMouse:point];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *t = [touches anyObject];
//    CGPoint p = [t locationInView:self.view];
//    NSValue *v = [NSValue valueWithCGPoint:p];
//    NSMutableData *data = [NSMutableData data];
//    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [arch encodeObject:v forKey:@"point"];
//    [arch finishEncoding];
//    [self.myNewScoket writeData:data withTimeout:-1 tag:0];
    UITouch *t = [touches anyObject];
    CGPoint point= [t locationInView:self.view];
    NSString *info = [NSString stringWithFormat:@"%f&&%f",point.x,point.y];
    NSData *data = [info dataUsingEncoding:NSUTF8StringEncoding];
    [self.myNewScoket writeData:data withTimeout:-1 tag:0];
}

-(void)addMouse:(CGPoint)point{
        JSMouse* mouse=[[JSMouse alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        mouse.SeverSocketDelegate=self;
        mouse.center=point;
        [self.view addSubview:mouse];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)seccuss{
    int count=self.deadMouse.text.intValue;
    self.deadMouse.text=[NSString stringWithFormat:@"%d",count+1];
}
-(void)failed{
    int count=self.escapeMouse.text.intValue;
    self.escapeMouse.text=[NSString stringWithFormat:@"%d",count+1];
}

@end
