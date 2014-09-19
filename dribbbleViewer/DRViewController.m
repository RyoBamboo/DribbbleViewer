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

@synthesize collectionView = _collectionView;

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
             //NSLog(@"responseObject: %@", dictionary);
         }failure:^(AFHTTPRequestOperation *operation, NSError *error){
             NSLog(@"%@", error);
         }];
    
    // PSCollectionViewの呼び出しと設定
    _collectionView = [[PSCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _collectionView.collectionViewDataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_collectionView];
    
    // 列挙する列数
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
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
    return 8;
}

- (CGFloat) collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 80.0f;
}


- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    DRCollectionViewCell *cell;
    cell = (DRCollectionViewCell *)[_collectionView dequeueReusableViewForClass:[DRCollectionViewCell class]];
    if (!cell) {
        cell = [[DRCollectionViewCell alloc]initWithFrame:CGRectZero];
    }
    
    return cell;
}
@end
