//
//  ViewController.m
//  NSOperation
//
//  Created by Civet on 2019/5/27.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 100 + 80*i, 120, 40);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101 +i;
        
        if (i == 0) {
            [btn setTitle:@"添加新任务1到队列中" forState:UIControlStateNormal];
        }
        else if (i == 1){
            [btn setTitle:@"添加新任务2到队列中" forState:UIControlStateNormal];
        }
        [self.view addSubview:btn];
    }
   //创建一个任务队列
    _queue = [[NSOperationQueue alloc] init];
    //设置最大并发任务数量
    [_queue setMaxConcurrentOperationCount:5];
    
}

- (void)pressBtn:(UIButton *)btn{
    if (btn.tag == 101) {
        //创建一个执行任务队列
        NSInvocationOperation *iop = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(opAct1:) object:@"OPT1"];
        [_queue addOperation:iop];
        //方法二来实现任务
        //创建任务对象
        NSInvocation *invo = [[NSInvocation alloc] init];
        invo.target = self;
        invo.selector = @selector(opAct1:);
    
        NSInvocationOperation *iop2 = [[NSInvocationOperation alloc] initWithInvocation:invo];
        [_queue addOperation:iop2];
    }
    else if(btn.tag == 102){
        //使用block语法块来进行任务处理
        [_queue addOperationWithBlock:^{
            int i = 0;
            while(i <= 10000){
                NSLog(@"block %d",i++);
            }
            i = 0;
        }];
    }
}

- (void)opAct1:(NSInvocationOperation *)opt{
    int i = 0;
    while(i <= 10000){
        NSLog(@"opt %d",i++);
    }
    i = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
