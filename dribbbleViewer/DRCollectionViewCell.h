//
//  DRCollectionViewCell.h
//  dribbbleViewer
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"

@interface DRCollectionViewCell : PSCollectionViewCell
{
    UIImageView *_imageView;
}


// クラスメソッド
+ (CGFloat)rowHeightForObject:(id)object;

@end