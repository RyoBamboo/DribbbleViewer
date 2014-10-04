//
//  DRCollectionViewCell.m
//  dribbbleViewer
//

#import "DRCollectionViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "DRShot.h"

@implementation DRCollectionViewCell


//-------------------------------------------
#pragma mark --- 初期化 ---
//-------------------------------------------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    // imageViewの初期化
    _imageView = [[UIImageView alloc]initWithFrame:frame];
    [self addSubview:_imageView];
    
    return self;
}

//-------------------------------------------
#pragma mark --- レイアウト ---
//-------------------------------------------
- (void)layoutSubviews
{
    [super layoutSubviews];
}

//-------------------------------------------
#pragma mark --- セルの表示 ---
//-------------------------------------------
- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    DRShot *shot = (DRShot *)object;
    
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)[shot imageTeaserURL]]];
}

+ (CGFloat)rowHeightForObject:(id)object
{
    // DRShot型に変換
    DRShot *shot = (DRShot *)object;
    
    CGFloat imageHeight = [NSString stringWithFormat:@"%@", [shot height]].floatValue;
    CGFloat imageWidth = [NSString stringWithFormat:@"%@", [shot width]].floatValue;
    
    return 150 * (imageHeight/imageWidth);
}

@end
