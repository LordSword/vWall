//
//  SDPlayerWindowManager.swift
//  vWall
//
//  Created by Sword on 2021/9/27.
//

import Cocoa
import AVKit
import CoreGraphics

class SDPlayerWindowManager: NSWindowController {

    @IBOutlet weak var playerView: AVPlayerView! {
        didSet {
            playerView.controlsStyle = .none
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.makeKeyAndOrderFront(self)
        window?.delegate = self
        window?.ignoresMouseEvents = true
        window?.level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(CGWindowLevelForKey(.desktopWindow)))
        window?.orderBack(self)
        window?.setFrame(NSScreen.main?.frame ?? NSMakeRect(0, 0, 0, 0), display: true, animate: false)
    }
    
    func playVideo(_ url: URL?) {
                
        guard nil != url else {
            return
        }
        
        showWindow(self)
        
        stopVideo()
                
        let player = AVPlayer(url: url!)
        playerView.player = player
        
        player.play()
        player.volume = 0
    }
    
    func stopVideo() {
        guard nil != playerView.player else {
            return
        }
        
        playerView.player?.pause()
        playerView.player = nil
    }
}

extension SDPlayerWindowManager: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        
        stopVideo()
    }
}
