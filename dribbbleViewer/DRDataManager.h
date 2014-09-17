//
//  DRDataManager.h
//  dribbbleViewer
//

#import <Foundation/Foundation.h>

@interface DRDataManager : NSObject
{
    NSManagedObjectContext *_managedObjectContext;
}

// プロパティ
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

// クラスメソッド
+ (DRDataManager *)sharedManager;

@end
