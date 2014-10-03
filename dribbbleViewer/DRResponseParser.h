//
//  DRResponseParser.h
//  dribbbleViewer
//
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "DRShot.h"
#import "DRShotsManager.h"

// ネットワークの状態
enum {
    DRNetworkStateNotConnected = 0,
    DRNetworkStateInProgress,
    DRNetworkStateFinished,
    DRNetworkStateError,
    DRNetworkStateCanceled
};

@class DRShot;

@interface DRResponseParser : NSObject
{
    int _networkState;
}

@property (nonatomic, readonly) int networkState;

- (void)getShots:(NSString *)category page:(NSString *)page;

@end
