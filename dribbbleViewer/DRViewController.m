//
//  DRViewController.m
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/09/16.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import "DRViewController.h"

@interface DRViewController ()

@end

@implementation DRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",[DRDataManager sharedManager].managedObjectContext);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
