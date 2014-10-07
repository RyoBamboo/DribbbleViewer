//
//  DRResponseParser.m
//  dribbbleViewer
//
#import "DRResponseParser.h"


@class DRShot;

@implementation DRResponseParser

@synthesize networkState = _networkState;
@synthesize delegate = _delegate;
@synthesize parsedShot = _parsedShot;

//--------------------------------------
#pragma mark --- 初期化 ---
//--------------------------------------
- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // インスタンス変数を初期化する
    _shots = [NSMutableArray array];
    
    return self;
}


//--------------------------------------
#pragma mark --- パース ---
//--------------------------------------
- (void)getShots:(NSString *)category page:(NSString *)page
{
    // パース済みのショットを作成する
    _parsedShot = [[DRShotsManager alloc]init];
    
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
    //[_shots removeAllObjects];
    
    for (NSDictionary *value in dict) {
        if (value) {
            // ショット作成
            DRShot *shot;
            shot = [[DRShot alloc]init];
            [_shots addObject:shot];
            
            // 値を取得
            shot.viewCount = (NSInteger)[value objectForKey:@"views_count"];
            shot.commentsCount = (NSInteger)[value objectForKey:@"comments_count"];
      //      shot.description = (NSString *)[value objectForKey:@"description"];
            shot.createAt = (NSString *)[value objectForKey:@"created_at"];
            shot.imageTeaserURL = (NSString *)[value objectForKey:@"image_teaser_url"];
            shot.imageURL = (NSString *)[value objectForKey:@"image_url"];
            shot.width = [value objectForKey:@"width"];
            shot.height = [value objectForKey:@"height"];
            shot.viewCount = 1;
            
            
            // ショットの保存
            //[[DRShotsManager sharedManager] addShot:shot];
        }
    }
    
    [_parsedShot.shots setArray:_shots];
    
    if ([_delegate respondsToSelector:@selector(parserDidFinishLoading:)]) {
        [_delegate parserDidFinishLoading:self];
    }
}

@end
