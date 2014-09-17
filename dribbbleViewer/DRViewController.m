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
//------------------------------------------------------
#pragma mark 初期化
//------------------------------------------------------
static NSDictionary *dictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // とりあえずAPIたたく
    NSString *itemUrl = @"http://api.dribbble.com/shots/everyone";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:itemUrl
     parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil] ;
             
             NSLog(@"responseObject: %@", dictionary);
         }failure:^(AFHTTPRequestOperation *operation, NSError *error){
             NSLog(@"%@", error);
         }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//------------------------------------------------------
#pragma mark PSCollectionView DataSource
//------------------------------------------------------
- (NSInteger) numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return [dictionary count];
}

- (CGFloat) collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 0;
}


- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    return nil;
}
@end
