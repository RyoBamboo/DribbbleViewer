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
