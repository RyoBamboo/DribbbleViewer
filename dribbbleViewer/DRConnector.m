//
//  DRConnector.m
//  dribbbleViewer
//

#import "DRConnector.h"
#import "DRResponseParser.h"
#import "DRShotsManager.h"
#import "DRShot.h"

NSString *DRConnectorDidBeginRefreshShots = @"DRConnectionDidBeginRefreshShots";
NSString *DRConnectorInProgressRefreshShots = @"DRConnectionInProgressRefreshShots";
NSString *DRConnectorDidFinishRefreshShots = @"DRConnectionDidFinishRefreshShots";

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

- (void)refreshShots:(NSString *)category page:(NSString *)page
{
    // もし更新中であれば何もしない
    if ([self isRefreshingShots]) {
        return;
    }
    
    // 現在のネットワークアクセス状況を取得
    BOOL networkAccessing;
    networkAccessing = self.networkAccessing;
    
    // CoreDataの初期化
    if ([page isEqualToString:@"1"]) {
        [[DRShotsManager sharedManager] removeAll];
    }
    
    // レスポンスパーサの作成
    DRResponseParser *parser;
    parser = [[DRResponseParser alloc]init];
    parser.delegate = self;
    
    // パースの追加
    [_refreshShotParsers addObject:parser];
    
    // パース開始
    [parser getShots:category page:page];
    
    // networkAccessingの値を変更を通知する
    if (networkAccessing != self.networkAccessing) {
        [self willChangeValueForKey:@"networkAccessing"];
        [self didChangeValueForKey:@"networkAccessing"];
    }
    
    // 通知
    [[NSNotificationCenter defaultCenter] postNotificationName:DRConnectorDidBeginRefreshShots object:self];
}


//--------------------------------------------------
#pragma mark --- DRResponseParser Delegate ---
//--------------------------------------------------
- (void)parserDidFinishLoading:(DRResponseParser *)parser
{
    for (DRShot *shot in parser.parsedShot.shots) {
        [[DRShotsManager sharedManager].shots addObject:shot];
    }
    
    // 通知
    [[NSNotificationCenter defaultCenter] postNotificationName:DRConnectorDidFinishRefreshShots object:self];
    
    // networkingAccessingの値を変更する
    [self willChangeValueForKey:@"networkAccessing"];
    [_refreshShotParsers removeAllObjects];
    [self didChangeValueForKey:@"networkAccessing"];
}

@end
