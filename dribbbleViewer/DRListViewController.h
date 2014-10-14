//
//  DRViewController.h
//  dribbbleViewer
//
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"
#import "DRCollectionViewCell.h"
#import "DRConnector.h"

@interface DRListViewController : UIViewController <PSCollectionViewDataSource, PSCollectionViewDelegate, UIScrollViewDelegate>
{
    PSCollectionView *_collectionView;
    NSString *_shotCategory;
    
    NSInteger _pageNum;
    BOOL _isLoading;
}

@property (nonatomic) PSCollectionView *collectionView;
@property (nonatomic) NSString *shotCategory;

@end
