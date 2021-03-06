//
//  AppDelegate.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "AppDelegate.h"
#import "XYGIMClient.h"
#import "XYGDConfig.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    NSArray *list = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Emotions" ofType:@"plist"]];
//    NSMutableArray *rootArray = [[NSMutableArray alloc] initWithArray:list];
//    NSMutableDictionary *rootDic = [[NSMutableDictionary alloc] initWithDictionary:rootArray[0]];
//    NSMutableArray *items = [NSMutableArray array];
//    NSArray *data = rootDic[@"items"];
//    for (int i = 0; i < data.count;i++) {
//        NSDictionary *info = data[i];
//        NSMutableDictionary *ain = [NSMutableDictionary dictionary];
//        [ain setObject:@(i) forKey:@"face_id"];
//        [ain setObject:info[@"image"] forKey:@"face_image_name"];
//        [ain setObject:[NSString stringWithFormat:@"[%@]",info[@"text"]] forKey:@"face_name"];
//        [ain setObject:@(0) forKey:@"face_rank"];
//        [ain setObject:info[@"image"] forKey:@"image"];
//        [ain setObject:info[@"text"] forKey:@"text"];
//        
//        [items addObject:ain];
//    }
//    [rootDic setObject:items forKey:@"items"];
//    [rootArray removeObjectAtIndex:0];
//    [rootArray insertObject:rootDic atIndex:0];
//    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    path = [path stringByAppendingString:@"/test.plist"];
//    [rootArray writeToFile:path atomically:YES];
    
    [XYGIMClient initIMType:XYGIMLibTypeWangYiYun];
    //[[XYGIMClient sharedClient] initWithType:XYGIMLibTypeWangYiYun];
    NSLog(@"-----%@-----",[[XYGIMClient sharedClient] version]);
    [self configureGDAPIKey];
    return YES;
}

#pragma mark - 配置高德地图

- (void)configureGDAPIKey {
    if ([APIKey length] == 0) {
        //[XYUtils showMessageAlertWithTitle:@"OK" message:@"apiKey为空，请检查key是否正确设置。"];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"XYGatherIM"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
