//
//  DRSideViewController.m
//  dribbbleViewer
//

#import "DRSideViewController.h"

@interface DRSideViewController ()

@end

@implementation DRSideViewController

//-----------------------------------------------------
#pragma mark --- 初期化　---
//-----------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-----------------------------------------------------
#pragma mark --- UITableView DataSource　---
//-----------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

//-----------------------------------------------------
#pragma mark --- UITableView Delegate　---
//-----------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
