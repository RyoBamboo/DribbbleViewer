//
//  DRCollectionViewCell.m
//  dribbbleViewer
//

#import "DRCollectionViewCell.h"

@implementation DRCollectionViewCell


//-------------------------------------------
#pragma mark --- 初期化 ---
//-------------------------------------------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//-------------------------------------------
#pragma mark --- レイアウト ---
//-------------------------------------------
- (void)layoutSubviews
{
    self.backgroundColor = [UIColor blackColor];
    [super layoutSubviews];
}

//-------------------------------------------
#pragma mark --- セルの表示 ---
//-------------------------------------------
- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    
}

+ (CGFloat)rowHeightForObject:(id)object
{
    return 0;
}

@end
