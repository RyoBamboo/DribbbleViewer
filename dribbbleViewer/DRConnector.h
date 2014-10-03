//
//  DRConnector.h
//  dribbbleViewer
//

#import <Foundation/Foundation.h>

extern NSString *DRConnectorDidBeginGetShots;
extern NSString *DRConnectorInProgressGetShots;
extern NSString *DRConnectorDidFinishGetShots;

@interface DRConnector : NSObject
{
    NSMutableArray *_refreshAllShotParsers;
}

// プロパティ
@property (nonatomic, readonly, getter = isNetworkingAccessing) BOOL networkAccessing;

// 初期化
+ (DRConnector *) sharedConnector;

// 登録した全てのショットの更新
- (BOOL)isRefreshingAllShots;
- (void)refreshAllShots;


@end
