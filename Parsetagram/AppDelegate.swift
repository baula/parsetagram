//
//  AppDelegate.swift
//  Parsetagram
//
//  Created by Baula Xu on 6/20/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "uhygrufjkeru3yrhf928p7y9p82rhdub"
                configuration.server = "https://stark-everglades-14506.herokuapp.com/parse"
            })
    )
        /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        
        let feedTabNavigationController = storyboard.instantiateViewControllerWithIdentifier("FeedNavigationController") as! UINavigationController
        //let feedTabViewController = feedTabNavigationController.topViewController as! FeedViewController
        feedTabNavigationController.tabBarItem.title = "Feed"
        //nowPlayingNavigationController.tabBarItem.image = UIImage(named: "video")
        
        let personalTabNavigationController = storyboard.instantiateViewControllerWithIdentifier("PersonalNavigationController") as! UINavigationController
        //let personalTabViewController = personalTabNavigationController.topViewController as! PersonalViewController
        personalTabNavigationController.tabBarItem.title = "Personal"
        //topRatedNavigationController.tabBarItem.image = UIImage(named: "user")
        
        let postTabNavigationController = storyboard.instantiateViewControllerWithIdentifier("PostNavigationController") as! UINavigationController
        //let postTabViewController = postTabNavigationController.topViewController as! PostViewController
        postTabNavigationController.tabBarItem.title = "Post"
        //popularNavigationController.tabBarItem.image = UIImage(named: "star")
        
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedTabNavigationController, personalTabNavigationController, postTabNavigationController]
        */
        
        
        if PFUser.currentUser() != nil {
            // "Main" is name of .storyboard file "
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newInitVC = storyboard.instantiateViewControllerWithIdentifier("tabBar") as UIViewController
            let navigationController = UINavigationController(rootViewController: newInitVC)
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            if let window = window {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
            /*else{
                window?.rootViewController = navigationController
                window?.makeKeyAndVisible()
            }*/
        }
 
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

