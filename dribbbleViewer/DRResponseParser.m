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
- (void)getShots:(NSString *)category page:(NSString *)page
{
    // リクエストの指定
    NSString *url = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%@", category];
    NSDictionary *params = @{@"page": page};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
         // 取得できたらパースしてCoreDataに保存
         NSArray *dict = [responseObject objectForKey:@"shots"];
         if ([dict count] > 0) {
             [self parse:dict];
         }
      }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
      }];
}

- (void)parse:(NSArray *)dict
{
    // DRShotの作成
    DRShot *shots;
}

@end