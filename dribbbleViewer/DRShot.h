//
//  DRShots.h
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/09/20.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRShot : NSObject
{
    NSInteger _viewCount;
    NSInteger _commentsCount;
    NSInteger _likeCount;
    NSString *_title;
    NSString *_createAt;
    NSString *_description;
    NSString *_imageTeaserURL;
    NSString *_imageURL;
    NSNumber *_width;
    NSNumber *_height;
}

@property (nonatomic) NSInteger viewCount;
@property (nonatomic) NSInteger commentsCount;
@property (nonatomic) NSInteger likeCount;
@property (nonatomic) NSString  *title;
@property (nonatomic) NSString  *createAt;
@property (nonatomic) NSString  *description;
@property (nonatomic) NSString  *imageTeaserURL;
@property (nonatomic) NSString  *imageURL;
@property (nonatomic) NSNumber  *width;
@property (nonatomic) NSNumber  *height;

@end
