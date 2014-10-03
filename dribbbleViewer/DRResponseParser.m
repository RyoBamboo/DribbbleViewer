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
    for (NSDictionary *value in dict) {
        if (value) {
            // ショット作成
            DRShot *shot;
            shot = [[DRShot alloc]init];
            
            // 値を取得
            shot.viewCount = (NSInteger)[value objectForKey:@"views_count"];
            shot.commentsCount = (NSInteger)[value objectForKey:@"comments_count"];
            shot.description = (NSString *)[value objectForKey:@"description"];
            shot.createAt = (NSString *)[value objectForKey:@"created_at"];
            shot.imageTeaserURL = (NSString *)[value objectForKey:@"image_teaser_url"];
            shot.imageURL = (NSString *)[value objectForKey:@"image_url"];
            shot.width = [value objectForKey:@"width"];
            shot.height = [value objectForKey:@"height"];
            
            // ショットの保存
            [[DRShotsManager sharedManager] addShot:shot];
        }
    }
    
    NSLog(@"%lu", (unsigned long)[[DRShotsManager sharedManager].shots count]);
}

@end
