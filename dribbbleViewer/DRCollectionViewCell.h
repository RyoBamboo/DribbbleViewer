//
//  DRCollectionViewCell.h
//  dribbbleViewer
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"

@interface DRCollectionViewCell : PSCollectionViewCell

// クラスメソッド
+ (CGFloat)rowHeightForObject:(id)object;

@end