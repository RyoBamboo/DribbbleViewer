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
    
    NSMutableArray *result = [[NSMutableArray alloc]initWithArray:@[]];
    
    // リクエストの指定
    NSString *url = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%@", category];
    NSDictionary *params = @{@"page": page};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
         // 取得できたらArray型に変換して返す
         NSArray *dict = [responseObject objectForKey:@"shots"];
         if ([dict count] > 0) {
             
             //個々でCoreDataに保存？
             
         }
      }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
      }];
    
    return nil;
}


@end
