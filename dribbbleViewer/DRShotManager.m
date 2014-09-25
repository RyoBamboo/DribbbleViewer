//
//  DRShotManager.m
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/09/26.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import "DRShotManager.h"

@implementation DRShotManager

@synthesize shots = _shots;

static DRShotManager *sharedInstance = nil;

+ (DRShotManager *)sharedManager
{
    if (!sharedInstance) {
        return sharedInstance;
    }
    
    sharedInstance = [[DRShotManager alloc]init];
    
    return sharedInstance;
}

@end
