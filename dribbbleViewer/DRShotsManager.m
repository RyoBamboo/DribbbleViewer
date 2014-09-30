//
//  DRShotsManager.m
//  dribbbleViewer
//

#import "DRShotsManager.h"

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

@end
