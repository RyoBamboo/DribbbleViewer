//
//  DRViewController.h
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/09/16.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRDataManager.h"
#import "DRResponseParser.h"
#import "PSCollectionView.h"
#import "DRCollectionViewCell.h"
#import "AFNetworking/AFNetworking.h"

@interface DRViewController : UIViewController <PSCollectionViewDataSource, PSCollectionViewDelegate, UIScrollViewDelegate>
{
    PSCollectionView *_collectionView;
    
    NSInteger _pageNum;
    BOOL _isLoading;
}

@property (nonatomic) PSCollectionView *collectionView;

@end
