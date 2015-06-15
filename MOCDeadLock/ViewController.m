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
    [DataManager sharedManager];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(UIButton *)sender
{
    NSLog(@"Test starting...");
    
    for (int x = 0; x < 10; x ++)
    {
        NSString *name = [NSString stringWithFormat:@"Test thread %d", x];
        [[[TestThread alloc] initWithName:name] start];
    }
}


@end
