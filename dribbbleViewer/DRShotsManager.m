//
//  DRShotsManager.m
//  dribbbleViewer
//

#import "DRShotsManager.h"
@class DRShot;

@implementation DRShotsManager

@synthesize shots = _shots;

//--------------------------------
#pragma mark --- 初期化 ---
//--------------------------------
static DRShotsManager *sharedInstance = nil;

+ (DRShotsManager *)sharedManager
{
    if (!sharedInstance) {
        sharedInstance = [[DRShotsManager alloc]init];
    }
    
    return sharedInstance;
}

//--------------------------------
#pragma mark --- ショットの操作 ---
//--------------------------------
// 追加
- (void)addShot:(DRShot *)shot
{
    if (!shot) {
        NSLog(@"Shot does't exist!");
        return;
    }
    
    [shots addObject:shot];
}

// 全削除
- (void)removeAll
{
    [shots removeAllObjects];
}


@end
