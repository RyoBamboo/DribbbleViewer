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
    
    DRShotsManager *_parsedShot;
    NSMutableArray *_shots;
}

@property (nonatomic, readonly) int networkState;
@property (nonatomic, assign) id delegate;
@property (retain) DRShotsManager *parsedShot;

// パース
- (void)getShots:(NSString *)category page:(NSString *)page;

// デリゲートメソッド

@end

@interface NSObject (DRResponseParserDelegate)

- (void)parserDidFinishLoading:(DRResponseParser *)parser;

@end