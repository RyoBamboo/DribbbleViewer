//
//  DRAppDelegate.m
//  dribbbleViewer
//

#import "DRAppDelegate.h"
#import "DRConnector.h"
#import "DRListViewController.h"
#import "DRTabBarController.h"

@implementation DRAppDelegate


//--------------------------------------------------------------------------
#pragma mark --- 初期化 ---
//--------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // キー値監視の登録
    [[DRConnector sharedConnector]
        addObserver:self forKeyPath:@"networkAccessing" options:0 context:NULL];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // UITabBarControllerの設置
    DRTabBarController *tabBarController = [[DRTabBarController alloc]init];
    
    DRListViewController *everyoneListViewController = [[DRListViewController alloc]init];
    UINavigationController *everyoneNavigationController = [[UINavigationController alloc]initWithRootViewController:everyoneListViewController];
                                                            
    DRListViewController *popularListViewController = [[DRListViewController alloc]init];
    UINavigationController *popularNavigationController = [[UINavigationController alloc]initWithRootViewController:popularListViewController];
    
    popularNavigationController.tabBarItem.title = @"popular";
    everyoneNavigationController.tabBarItem.title = @"everyone";
    
    tabBarController.viewControllers = @[everyoneNavigationController, popularNavigationController];
    
    self.window.rootViewController = tabBarController;
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//--------------------------------------------------------------------------
#pragma mark --- NSKeyValueObserving protocol ---
//--------------------------------------------------------------------------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // networkAccessingキーの場合
    if ([keyPath isEqualToString:@"networkAccessing"]) {
        NSLog(@"change networkAccessing!!!");
    }
}
@end
