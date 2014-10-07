//
//  DRTabBarController.m
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/10/07.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import "DRTabBarController.h"
#import "DRTabBar.h"

@interface DRTabBarController ()

@end

@implementation DRTabBarController

//-------------------------------------------------
#pragma mark --- 初期化 ---
//-------------------------------------------------
- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self setLayout];
    
    return self;
}

- (void)setLayout
{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
