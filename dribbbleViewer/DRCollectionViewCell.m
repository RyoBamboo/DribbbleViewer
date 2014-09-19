//
//  DRCollectionViewCell.m
//  dribbbleViewer
//

#import "DRCollectionViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

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
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    [_imageView setImageWithURL:[NSURL URLWithString:(NSString *)[object objectForKey:@"image_teaser_url"]]];
}

+ (CGFloat)rowHeightForObject:(id)object
{
    CGFloat imageHeight = [NSString stringWithFormat:@"%@", [object objectForKey:@"height"]].floatValue;
    CGFloat imageWidth = [NSString stringWithFormat:@"%@", [object objectForKey:@"width"]].floatValue;
    
    return 150 * (imageHeight/imageWidth);
}

@end
