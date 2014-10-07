//
//  DRViewController.m
//  dribbbleViewer
//

#import "DRListViewController.h"
#import "DRShotsManager.h"
#import "DRConnector.h"
#import "IIViewDeckController.h"


@interface DRListViewController ()

@end

@implementation DRListViewController

@synthesize collectionView = _collectionView;
@synthesize shotCategory = _shotCategory;

//------------------------------------------------------
#pragma mark --- 初期化 ---
//------------------------------------------------------

- (void)_init
{
    // NavigationBarの設定
    self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0];
    self.title = @"Dribbble";
    
    // タイトルを取得
}

- (id)init
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    [self _init];
    
    return self;
}


//------------------------------------------------------
#pragma mark --- ビュー ---
//------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // shotを初期化する
    [[DRShotsManager sharedManager].shots removeAllObjects];
    
    // タイトルを取得する
    _shotCategory = self.navigationController.tabBarItem.title;
    
    // 画面を更新する
    [self _updateNavigationItem:animated];
    
    
    // ステータスバーを非表示にする
    if( [ UIApplication sharedApplication ].isStatusBarHidden == NO ) {
        [ UIApplication sharedApplication ].statusBarHidden = YES;
    }
    
    _pageNum = 1;
    
    // 通知の登録
    NSNotificationCenter *center;
    center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(connectorDidBeginRefreshShots:) name:DRConnectorDidBeginRefreshShots object:nil];
    [center addObserver:self selector:@selector(connectorInProgressRefreshShots:) name:DRConnectorInProgressRefreshShots object:nil];
    [center addObserver:self selector:@selector(connectorDidFinishRefreshShots:) name:DRConnectorDidFinishRefreshShots object:nil];
    
    [[DRConnector sharedConnector]refreshShots:_shotCategory page:@"1"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------
#pragma mark --- 画面の更新 ---
//------------------------------------------------------
- (void)_updateNavigationItem:(BOOL)animated
{
    // ナビゲーションアイテムの設定を行う
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"logo.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self.viewDeckController action:@selector(toggleLeftView)];
    
    [self.navigationItem setLeftBarButtonItem:listButton animated:animated];
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
#pragma mark --- UIScrollView DataSource ---
//------------------------------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_shotCategory &&![[DRConnector sharedConnector] isNetworkAccessing] && _collectionView.contentOffset.y >= (_collectionView.contentSize.height - _collectionView.bounds.size.height)) {
        _pageNum ++;
        NSString *pageNum = [NSString stringWithFormat:@"%ld", (long)_pageNum];
        
        // 次のページの読み込み
        [[DRConnector sharedConnector] refreshShots:_shotCategory page:pageNum];
    }
}


//------------------------------------------------------
#pragma mark --- DRConnector NSNotification ---
//------------------------------------------------------
- (void)connectorDidBeginRefreshShots:(NSNotification *)notification
{
}

- (void)connectorInProgressRefreshShots:(NSNotification *)notification
{
}

- (void)connectorDidFinishRefreshShots:(NSNotification *)notification
{
    [self.collectionView reloadData];
}
@end
