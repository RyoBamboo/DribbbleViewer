//
//  DRResponseParser.m
//  dribbbleViewer
//
#import "DRResponseParser.h"

@class DRShot;

@implementation DRResponseParser

//--------------------------------------
#pragma mark --- 初期化 ---
//--------------------------------------
- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}


//--------------------------------------
#pragma mark --- パース ---
//--------------------------------------
- (NSMutableArray *)getShots:(NSString *)category page:(NSString *)page
{
    NSString *url = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%@", category];
    NSDictionary *params = @{@"page": page};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    return nil;
}

@end
