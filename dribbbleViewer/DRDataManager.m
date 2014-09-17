//
//  DRDataManager.m
//  dribbbleViewer
//
//  Created by 竹之下遼 on 2014/09/17.
//  Copyright (c) 2014年 Ryobamboo. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DRDataManager.h"

@implementation DRDataManager

@synthesize managedObjectContext = _managedObjectContext;

//---------------------------------------------------
#pragma mark --- 初期化 ---
//---------------------------------------------------
static DRDataManager *_sharedInstance = nil;

+ (DRDataManager *)sharedManager
{
    if (!_sharedInstance) {
        _sharedInstance = [[DRDataManager alloc]init];
    }
    
    return _sharedInstance;
}


//---------------------------------------------------
#pragma mark --- ゲッタ ---
//---------------------------------------------------
- (NSManagedObjectContext *)managedObjectContext
{
    NSError *error;
    
    // インスタンスが既に初期化されていたら返す
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    // NSManagedObjectModelの作成
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // NSPersistentStoreCoordinatorの作成
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
    
    /*---------------------------------
      保存ファイルの作成
    ---------------------------------*/
    NSArray  *paths;
    NSString *path = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingString:@".dr"];
        path = [path stringByAppendingString:@".dr.db"];
    }
    
    if (!path) {
        return nil;
    }
    
    /*---------------------------------
      ディレクトリの作成
    ---------------------------------*/
    NSString *dirPath;
    NSFileManager *firMgr;
    dirPath = [path stringByDeletingLastPathComponent];
    firMgr = [NSFileManager defaultManager];
    // ディレクトリが存在しなければ作成する
    if (![firMgr fileExistsAtPath:dirPath]) {
        if (![firMgr createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Failed to create directory at path %@, error %@", dirPath, [error localizedDescription]);
        }
    }
    
    // ストアURLの作成
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    
    // 永続ストアの追加
    NSPersistentStore *persistentStore = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                   configuration:nil URL:storeURL
                                                                         options:nil error:&error];
    
    if (!persistentStore && error) {
        NSLog(@"Failed to create add Persistent store, %@", [error localizedDescription]);
    }
    
    // NSManagedObjectContextの作成
    _managedObjectContext = [[NSManagedObjectContext alloc]init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}




@end
