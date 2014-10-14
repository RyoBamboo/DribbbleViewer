//
//  DRShotsManager.h
//  dribbbleViewer
//
//

#import <Foundation/Foundation.h>
@class DRShot;

@interface DRShotsManager : NSObject

// プロパティ
@property (nonatomic, readonly) NSMutableArray *shots;

// 初期化
+ (DRShotsManager *)sharedManager;

// ショットの操作
- (void)addShot:(DRShot *)shot;
- (void)removeAll;

@end
