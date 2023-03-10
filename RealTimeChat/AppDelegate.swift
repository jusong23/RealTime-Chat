//
//  AppDelegate.swift
//  RealTimeChat
//
//  Created by mobile on 2023/02/20.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    
        Messaging.messaging().token { token, error in
            if let error = error {
                print("ERROR|FCM 등록토큰 가져오기: \(error) ")
            } else if let token = token {
                print("FCM 등록토큰: \(token)")
                Secret.token = token
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for Apple Remote Notifications")
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
            if let error = error {
                print("ERROR|Request Notificattion Authorization : \(error)")
            }
        }
        application.registerForRemoteNotifications()
        return true
    }
}

extension AppDelegate: MessagingDelegate {
    //FCM 토큰 갱신 시점 확인
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let refreshedToken = fcmToken else { return }
        print("FCM 등록토큰 갱신: \(refreshedToken)")
        Secret.refreshedToken = refreshedToken // 값이 같지 않다면 refreshedToken을 이용하기
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge, .sound])
    }
}
