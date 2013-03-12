//
//  AppDelegate.m
//
//  Created by hisasann on 11/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

// アプリ起動時
// アプリのプロセスがバックグラウンドで生きていないときにプッシュ通知を受け取り、ユーザーがアクションボタンをタップしたとき
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    // Pushから起動した
    if (userInfo) {
        NSDictionary *aps = [userInfo objectForKey:@"aps"];
        NSDictionary *badge = [NSDictionary dictionaryWithObject:[aps objectForKey:@"badge"] forKey:@"badgeCount"];

        // ☆ここでオリジナル処理
        // アプリ内のバッジの更新など
    }

    // token取得のためアプリ起動時にapnsにリクエストを送信
    [[UIApplication sharedApplication]
            registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                    UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // tokenをserver側でpush通知する際に使用する形式に加工
    NSString *token = [[[[deviceToken description]
            stringByReplacingOccurrencesOfString:@"<" withString:@""]
            stringByReplacingOccurrencesOfString:@">"
                                      withString:@""]
            stringByReplacingOccurrencesOfString:@" "
                                      withString:@""];
//    NSLog(@"token - %@", token);
//    NSLog(@"UUID - %@", [UUIDUtil id]);

    // ☆tokenとuuidをサーバーに登録
}

// アプリのプロセスがバックグラウンドで生きているときにプッシュ通知を受け取り、ユーザーがアクションボタンをタップしたとき
// フォアグラウンドでプッシュ通知を受け取ったとき
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    if (UIApplicationStateInactive == application.applicationState) {
        // バックグラウンドでユーザが通知情報をタップしたことによってフォアグラウンドになった
        // バックグラウンドからフォアグラウンドになった場合で、アプリ内のバッジを更新したい場合は、
        // ここに書くだけでは弱く、ホームボタンからタップされる可能性もあるので、applicationDidBecomeActiveで行う
    } else if (UIApplicationStateActive == application.applicationState) {
        // フォアグラウンドでバリバリ動いてる最中にpushが飛んできた
        // バッジ更新
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1]; // 指定秒後に実行
        notification.alertBody = [aps objectForKey:@"alert"];
        notification.applicationIconBadgeNumber = [[aps objectForKey:@"badge"] intValue];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];

        NSDictionary *badge = [NSDictionary dictionaryWithObject:[aps objectForKey:@"badge"] forKey:@"badgeCount"];

        // ☆ここでオリジナル処理
    }
}

// tokenの取得に失敗した際に呼ばれる
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

// アクティブになった場合
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    UIApplication *app = [UIApplication sharedApplication];
//    NSLog(@"badge - %d", app.applicationIconBadgeNumber);

    NSDictionary *badge = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:app.applicationIconBadgeNumber] forKey:@"badgeCount"];

    // ☆ここでオリジナル処理
    // アプリ内のバッジの更新など
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
