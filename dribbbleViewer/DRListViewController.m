//
//  DRViewController.m
//  dribbbleViewer
//

#import "DRListViewController.h"
#import "DRShotsManager.h"
#import "IIViewDeckController.h"


@interface DRListViewController ()

@end

@implementation DRListViewController

@synthesize collectionView = _collectionView;

//------------------------------------------------------
#pragma mark --- 初期化 ---
//------------------------------------------------------
static NSDictionary *dictionary;
static NSMutableArray *shots;

- (void)_init
{
    self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0];
    self.title = @"Everyone";
                    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"tst");
          
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
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
    
    // 画面を更新する
    [self _updateNavigationItem:animated];
    
    
    // ステータスバーを非表示にする
    if( [ UIApplication sharedApplication ].isStatusBarHidden == NO ) {
        [ UIApplication sharedApplication ].statusBarHidden = YES;
    }
    
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
