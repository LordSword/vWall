//
//  SDMenuManager.swift
//  vWall
//
//  Created by Sword on 2021/9/26.
//

import Cocoa

class SDMenuManager: NSObject {
    
    static let shared = SDMenuManager()
    var statusIcon: NSStatusItem?
    @IBOutlet weak var menu: NSMenu!
    
    func openStatusIcon() {
        _ = Bundle.main.loadNibNamed("MainMenu", owner: self, topLevelObjects: nil)
        
        let image = NSImage(named: "vWall")
        image?.isTemplate = true
        
        statusIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusIcon?.button?.image = image
        
        statusIcon?.menu = menu
    }
    
    @IBAction func chooseVideo(_ sender: NSMenuItem) {
        
        let dialog = NSOpenPanel();

        dialog.title = "选择一个视频";
        dialog.allowedFileTypes = ["mp4"]
        dialog.showsResizeIndicator = true;
        dialog.showsHiddenFiles = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = false;

        if (.OK == dialog.runModal()) {

            if let result = dialog.url {
                let path = result.path
                
                
                
                print(path)
            }
        } else {
            // 有妖气，快闪
        }
    }
    
    @IBAction func quitChicked(_ sender: NSMenuItem) {
        
        NSApplication.shared.terminate(sender)
    }
}
