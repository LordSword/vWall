//
//  SDMenuManager.swift
//  vWall
//
//  Created by Sword on 2021/9/26.
//

import Cocoa
import ServiceManagement

class SDMenuManager: NSObject {
    // 单例
    static let shared = SDMenuManager()
    // 属性
    var statusIcon: NSStatusItem?
    // xib属性
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var bootItem: NSMenuItem! {
        didSet {
            bootItem.state = bootOpened ? .on:.off
        }
    }
    // 懒加载
    lazy var playerManager = {
        return SDPlayerWindowManager(windowNibName: "PlayerWindow")
    }()
    // 计算属性
    var bootOpened:Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "bootDidOpened")
            UserDefaults.standard.synchronize()
            
            bootItem.state = newValue ? .on:.off
        }
        get {
            return UserDefaults.standard.bool(forKey: "bootDidOpened")
        }
    }
    
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
        
        if let data = UserDefaults.standard.data(forKey: "com.userSelected.url") {
            
            var bookmarkDataIsStale = true
            let url = try? URL(resolvingBookmarkData: data, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &bookmarkDataIsStale)
            if url?.startAccessingSecurityScopedResource() ?? false {
                
                self.openVideo(url)
                url?.stopAccessingSecurityScopedResource()
            }
        }
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
        
        openVideo(dialog.url)
    }
    
    @IBAction func bootClicked(_ sender: NSMenuItem) {
                        
        if SMLoginItemSetEnabled( "SD.vWallBootHelper" as CFString, !bootOpened) {
            
            bootOpened = !bootOpened
        }
    }
    
    @IBAction func quitChicked(_ sender: NSMenuItem) {
        
        NSApplication.shared.terminate(sender)
    }
}

extension SDMenuManager {
    
    func openVideo(_ url: URL?) {
        guard nil != url else {
            return
        }
        
        playerManager.playVideo(url)
        
        if let data = try? url?.bookmarkData(options: .securityScopeAllowOnlyReadAccess, includingResourceValuesForKeys: nil, relativeTo: nil) {
            UserDefaults.standard.set(data, forKey: "com.userSelected.url")
            UserDefaults.standard.synchronize()
        }
    }
}
