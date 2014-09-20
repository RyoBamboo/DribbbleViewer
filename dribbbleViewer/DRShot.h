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
}

@end
