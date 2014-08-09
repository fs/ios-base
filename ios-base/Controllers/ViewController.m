//
//  ViewController.m
//  ios-base
//
//  Created by Danis Ziganshin on 14.02.14.
//  Copyright (c) 2014 FlatStack. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[APIManager sharedManager] getCurrentDateWithCompleteBlock:^(id object) {
        NSDate *currentDate = (NSDate *)object;
        NSString *dateString = [currentDate formattedTime];
        [UIAlertView bk_showAlertViewWithTitle:@"current date" message:dateString cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
    }];
    
    dispatch_after_short(0.2, ^{
        NSLog(@"Hello world");
    });
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 260, 260)];
    v.backgroundColor = [UIColor redColor];
    v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [v addShineGradient];
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
