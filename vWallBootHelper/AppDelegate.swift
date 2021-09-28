//
//  AppDelegate.swift
//  vWallBootHelper
//
//  Created by Sword on 2021/9/28.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let runningApps = NSWorkspace.shared.runningApplications
        
        var isRunning = false
        
        for app in runningApps {
            // 判断app有没有在运行
            if "com.sdf.vWall" == app.bundleIdentifier {
                isRunning = true
                break
            }
        }
        
        // 没有在运行，启动APP
        if !isRunning {
            // 获取当前沙盒路径
//            var paths = Bundle.main.bundlePath.split(separator: "/")
//            paths.removeLast()
//            paths.removeLast()
//            paths.removeLast()
//
//            paths.append("MacOs")
//            paths.append("vWall")
//
//            let vWallPath = paths.joined(separator: "/")
            NSWorkspace.shared.launchApplication("vWall")
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

