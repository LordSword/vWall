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
        
//        if #available(macOS 10.15, *) {
//            // url 不对
//            let url = URL(fileURLWithPath: "vWall.app")
//            NSWorkspace.shared.openApplication(at: url, configuration: NSWorkspace.OpenConfiguration()) { runningApplication, Error in
//
//            }
//        } else {
//            NSWorkspace.shared.launchApplication("vWall")
            NSWorkspace.shared.launchApplication(withBundleIdentifier: "com.sdf.vWall", options: .withoutActivation, additionalEventParamDescriptor: nil, launchIdentifier: nil)
//        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

