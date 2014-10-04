//
//  DRViewController.m
//  dribbbleViewer
//

#import "DRViewController.h"
#import "DRShotsManager.h"


@interface DRViewController ()

@end

@implementation DRViewController

@synthesize collectionView = _collectionView;

//------------------------------------------------------
#pragma mark --- 初期化 ---
//------------------------------------------------------
static NSDictionary *dictionary;
static NSMutableArray *shots;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 情報の取得
    
    _isLoading = YES;
    _pageNum = 1;
    
    // 通知の登録
    NSNotificationCenter *center;
    center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(connectorDidBeginRefreshShots:) name:DRConnectorDidBeginRefreshShots object:nil];
    [center addObserver:self selector:@selector(connectorInProgressRefreshShots:) name:DRConnectorInProgressRefreshShots object:nil];
    [center addObserver:self selector:@selector(connectorDidFinishRefreshShots:) name:DRConnectorDidFinishRefreshShots object:nil];
    
    [[DRConnector sharedConnector]refreshShots];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DRResponseParser *perse = [[DRResponseParser alloc]init];
    [perse getShots:@"everyone" page:@"1"];
    
    
//    NSString *itemUrl = @"http://api.dribbble.com/shots/everyone";
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:itemUrl
//     parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil] ;
//             
//             NSLog(@"%@", dictionary);
//             [self setData:dictionary];
//         }failure:^(AFHTTPRequestOperation *operation, NSError *error){
//             NSLog(@"%@", error);
//         }];
    
    // PSCollectionViewの呼び出しと設定
    _collectionView = [[PSCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _collectionView.collectionViewDataSource = self;
    _collectionView.delegate = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_collectionView];
    
    // 列挙する列数
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
}

// とりあえずここで保存
/*
- (void) setData:(NSDictionary *)data{
    NSArray *array = [data objectForKey:@"shots"];
    shots = [NSMutableArray arrayWithArray:array];
    
    [_collectionView reloadData];
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//------------------------------------------------------
#pragma mark --- PSCollectionView DataSource ---
//------------------------------------------------------
- (NSInteger) numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return [[DRShotsManager sharedManager].shots count];
}

- (CGFloat) collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    
    DRShot *shot = [[DRShotsManager sharedManager].shots objectAtIndex:index];
    return [DRCollectionViewCell rowHeightForObject:shot];
   // return [DRCollectionViewCell rowHeightForObject:[shots objectAtIndex:index]];
}


- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    
    DRShot *shot = [[DRShotsManager sharedManager].shots objectAtIndex:index];
    
    DRCollectionViewCell *cell;
    cell = (DRCollectionViewCell *)[_collectionView dequeueReusableViewForClass:[DRCollectionViewCell class]];
    if (!cell) {
        CGFloat height = [DRCollectionViewCell rowHeightForObject:shot];
        cell = [[DRCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2 -10, height)];
    }
    
    [cell collectionView:_collectionView fillCellWithObject:shot atIndex:index];
    
    return cell;
}

//------------------------------------------------------
#pragma mark --- PSCollectionView DataSource ---
//------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_isLoading && _collectionView.contentOffset.y >= (_collectionView.contentSize.height - _collectionView.bounds.size.height)) {
        _pageNum ++;
    }
}


//------------------------------------------------------
#pragma mark --- DRConnector NSNotification ---
//------------------------------------------------------
- (void)connectorDidBeginRefreshShots:(NSNotification *)notification
{
    NSLog(@"begin!!");
}

- (void)connectorInProgressRefreshShots:(NSNotification *)notification
{
    NSLog(@"InProgress!!");
}

- (void)connectorDidFinishRefreshShots:(NSNotification *)notification
{
    [self.collectionView reloadData];
    NSLog(@"Finish!!");
}
@end
