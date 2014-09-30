//
//  DRShotsManager.h
//  dribbbleViewer
//
//

#import <Foundation/Foundation.h>
@class DRShot;

@interface DRShotsManager : NSObject
{
    NSMutableArray *shots;
}

// プロパティ
@property (nonatomic) NSMutableArray *shots;

// 初期化
+ (DRShotsManager *)sharedManager;

@end
