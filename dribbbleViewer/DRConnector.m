//
//  DRConnector.m
//  dribbbleViewer
//

#import "DRConnector.h"

@implementation DRConnector

//--------------------------------------------------
#pragma mark --- 初期化 ---
//--------------------------------------------------
static DRConnector *sharedInstance = nil;

+ (DRConnector *)sharedConnector
{
    if (!sharedInstance) {
        sharedInstance = [[DRConnector alloc]init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // インスタンス変数の初期化
    _refreshAllShotParsers = [NSMutableArray array];
    
    return self;
}

//--------------------------------------------------
#pragma mark --- プロパティ ---
//--------------------------------------------------
- (BOOL)isNetworkAccessing
{
    return [_refreshAllShotParsers count] > 0;
}


//--------------------------------------------------
#pragma mark --- ショットの更新 ---
//--------------------------------------------------
- (BOOL)isRefreshingAllShots
{
    return [_refreshAllShotParsers count] > 0;
}

- (void)refreshAllShots
{
    // 現在の更新状況を確認
    if ([self isRefreshingAllShots]) {
        return;
    }
    
    // 現在のネットワークアクセス状況を取得
    BOOL isNetworkAccessing = self.isNetworkingAccessing;
    
    // CoreDataの初期化
    
    // パース開始
    
    // 通知
}

@end
