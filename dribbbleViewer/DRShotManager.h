//
//  DRShotManager.h
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/09/26.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRShotManager : NSObject
{
    NSMutableArray *_shots;
}

// プロパティ
@property (nonatomic) NSMutableArray *shots;

// メソッド
+ (DRShotManager *)sharedManager;
@end
