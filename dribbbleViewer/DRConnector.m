//
//  DRConnector.m
//  dribbbleViewer
//

#import "DRConnector.h"
#import "DRResponseParser.h"
#import "DRShotsManager.h"
#import "DRShot.h"

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
    _refreshShotParsers = [NSMutableArray array];
    
    return self;
}

//--------------------------------------------------
#pragma mark --- プロパティ ---
//--------------------------------------------------
- (BOOL)isNetworkAccessing
{
    return [_refreshShotParsers count] > 0;
}


//--------------------------------------------------
#pragma mark --- ショットの更新 ---
//--------------------------------------------------
- (BOOL)isRefreshingShots
{
    return [_refreshShotParsers count] > 0;
}

- (void)refreshShots
{
    // もし更新中であれば何もしない
    if ([self isRefreshingShots]) {
        return;
    }
    
    // 現在のネットワークアクセス状況を取得
    BOOL networkAccessing;
    networkAccessing = self.networkAccessing;
    
    // CoreDataの初期化
    [[DRShotsManager sharedManager] removeAll];
    
    // レスポンスパーサの作成
    DRResponseParser *parser;
    parser = [[DRResponseParser alloc]init];
    
    // パースの追加
    [_refreshShotParsers addObject:parser];
    
    // パース開始
    [parser getShots:@"everyone" page:@"1"];
    
    // networkAccessingの値を変更を通知する
    if (networkAccessing != self.networkAccessing) {
        [self willChangeValueForKey:@"networkAccessing"];
        [self didChangeValueForKey:@"networkAccessing"];
    }
}

@end
