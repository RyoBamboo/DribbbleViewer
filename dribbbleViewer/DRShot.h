//
//  DRShots.h
//  dribbbleViewer
//
//

#import <Foundation/Foundation.h>

@interface DRShot : NSObject

@property (nonatomic) NSInteger viewCount;
@property (nonatomic) NSInteger commentsCount;
@property (nonatomic) NSInteger likeCount;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *createAt;
@property (nonatomic, strong) NSString  *imageTeaserURL;
@property (nonatomic, strong) NSString  *imageURL;
@property (nonatomic, strong) NSNumber  *width;
@property (nonatomic, strong) NSNumber  *height;

@end
