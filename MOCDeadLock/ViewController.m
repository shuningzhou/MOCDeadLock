//
//  ViewController.m
//  MOCDeadLock
//
//  Created by shuning zhou on 2015-06-03.
//  Copyright (c) 2015 Intrahealth. All rights reserved.
//

#import "ViewController.h"
#import "TestThread.h"
#import "DataManager.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(UIButton *)sender
{
    NSLog(@"Test starting...");

    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(runTest) userInfo:nil repeats:YES];
}

- (void)runTest;
{
    NSLog(@"Run test");
    
    for (int x = 0; x < 10; x ++)
    {
        NSString *name = [NSString stringWithFormat:@"Test thread %d", self.count];
        TestThread *thread = [[TestThread alloc] initWithName:name];
        [thread start];
        self.count ++;
    }
}

@end
