//
//  JSClientSocketViewController.m
//  Demo1_JS_HitMouseOnline
//
//  Created by  江苏 on 16/3/27.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSClientSocketViewController.h"
#import "AsyncSocket.h"
#import "JSMouse.h"
@interface JSClientSocketViewController ()<AsyncSocketDelegate>
@property(nonatomic,strong)AsyncSocket* clientSocket;
@property(nonatomic)float showX;
@property(nonatomic)float showY;
@property (strong, nonatomic) IBOutlet UILabel *connectionStaus;
@end

@implementation JSClientSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clientSocket=[[AsyncSocket alloc]initWithDelegate:self];
    [self.clientSocket connectToHost:@"192.168.1.103" onPort:8000 error:nil];
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    //客户端接收数据
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    self.connectionStaus.text=@"连接成功";
    
}
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *info  = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray* points=[info componentsSeparatedByString:@"&&"];
    self.showX=[points[0] intValue];
    self.showY=[points[1] intValue];
    [sock readDataWithTimeout:-1 tag:0];
    CGPoint point=CGPointMake(self.showX, self.showY);
    [self addMouse:point];
//    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//    NSValue *v = [unArch decodeObjectForKey:@"point"];
//    CGPoint p = [v CGPointValue];
//    [self addMouse:p];
//    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint point= [t locationInView:self.view];
    NSString *info = [NSString stringWithFormat:@"%f&&%f",point.x,point.y];
    NSData *data = [info dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
//    UITouch *t = [touches anyObject];
//    CGPoint p = [t locationInView:self.view];
//    NSValue *v = [NSValue valueWithCGPoint:p];
//    NSMutableData *data = [NSMutableData data];
//    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [arch encodeObject:v forKey:@"point"];
//    [arch finishEncoding];    
//    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}
-(void)addMouse:(CGPoint)point{
    JSMouse* mouse=[[JSMouse alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    mouse.ClientSocketDelegate=self;
    mouse.center=point;
    [self.view addSubview:mouse];
}
-(void)seccuss{
    int count=self.deadMouse.text.intValue;
    self.deadMouse.text=[NSString stringWithFormat:@"%d",count+1];
}
-(void)failed{
    int count=self.escapeMouse.text.intValue;
    self.escapeMouse.text=[NSString stringWithFormat:@"%d",count+1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
