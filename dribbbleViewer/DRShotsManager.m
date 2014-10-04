//
//  DRShotsManager.m
//  dribbbleViewer
//

#import "DRShotsManager.h"
#import "DRShot.h"

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

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // ショットの初期化
    _shots = [NSMutableArray array];
    
    return self;
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
    
    [_shots addObject:shot];
    
}

// 全削除
- (void)removeAll
{
    [shots removeAllObjects];
}


@end
