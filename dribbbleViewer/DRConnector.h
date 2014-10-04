//
//  DRConnector.h
//  dribbbleViewer
//

#import <Foundation/Foundation.h>

extern  NSString *DRConnectorDidBeginRefreshShots;
extern  NSString *DRConnectorInProgressRefreshShots;
extern  NSString *DRConnectorDidFinishRefreshShots;

@interface DRConnector : NSObject
{
    NSMutableArray *_refreshShotParsers;
}

// プロパティ
@property (nonatomic, readonly, getter = isNetworkAccessing) BOOL networkAccessing;

// 初期化
+ (DRConnector *) sharedConnector;

//ショットの更新
- (BOOL)isRefreshingShots;
- (void)refreshShots;


@end
