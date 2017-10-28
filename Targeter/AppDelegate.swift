//
//  AppDelegate.swift
//  Targeter
//
//  Created by mac on 3/8/17.
//  Copyright © 2017 Alder. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var stack = CoreDataStack(modelName: "Model")!
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if shortcutItem.type == "com.alder.Targeter.addTarget" {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addTargetVC = storyboard.instantiateViewController(withIdentifier: "AddTargetVC") as! AddTargetVC
            let targetsVC = storyboard.instantiateViewController(withIdentifier: "TargetsVC") as! TargetsVC
            let navController = UINavigationController.init(rootViewController: targetsVC)
          /*
            if let window = self.window, let rootViewController = window.rootViewController {
                var currentController = rootViewController
                while let presentedController = currentController.presentedViewController {
                    currentController = presentedController
                }
                currentController.present(navController, animated: true, completion: nil)
            }
            
            */
            navController.viewControllers.append(addTargetVC)
            
            
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
        }
        completionHandler(true)
    }
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (allowed, error) in
            if !allowed {
                print(error)
            } else {
                print("Notification access granded")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(1)
     //   func getTargetsFromCore() {
            do {
                let targets = try stack.context.fetch(Target.fetchRequest()) as [Target]
                var targetsMarked = 0
                for target in targets {
                    if let successList = target.successList as? Set<Success>, (successList.count > 0) {
                    //func todayIn(successList:Set<Success>,today:Date) -> (String,Success?){
                        for day in successList {
                            if Calendar.current.isDate(day.date, equalTo: Date(), toGranularity:.day) {
                                if day.success {
                                    targetsMarked += 1
                                } else {
                                    print("failed")
                                    return
                                }
                            }
                        }
                     //   return ("nothing", nil)
                    }
                }
                if targetsMarked != targets.count {
                   // completionHandler(nil)
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification.request.identifier])
                    
                }
                //self.mapView.addAnnotations(annotations)
            }  catch {
                print("error")
            }
    //    }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

