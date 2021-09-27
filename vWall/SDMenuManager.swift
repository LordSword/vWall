//
//  SDMenuManager.swift
//  vWall
//
//  Created by Sword on 2021/9/26.
//

import Cocoa

class SDMenuManager: NSObject {
    // 单例
    static let shared = SDMenuManager()
    // 属性
    var statusIcon: NSStatusItem?
    // xib属性
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var bootItem: NSMenuItem!
    // 懒加载
    lazy var playerManager = {
        return SDPlayerWindowManager(windowNibName: "PlayerWindow")
    }()
    
    override init() {
        super.init()
        _ = Bundle.main.loadNibNamed("MainMenu", owner: self, topLevelObjects: nil)
    }
    
    func openStatusIcon() {
        
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

        guard .OK == dialog.runModal() else {
            // 有妖气，快闪
            return
        }
        
        playerManager.playVideo(dialog.url)
    }
    
    @IBAction func bootClicked(_ sender: NSMenuItem) {
        
    }
    
    @IBAction func quitChicked(_ sender: NSMenuItem) {
        
        NSApplication.shared.terminate(sender)
    }
}
