//
//  SDPlayerWindowManager.swift
//  vWall
//
//  Created by Sword on 2021/9/27.
//

import Cocoa
import AVKit

class SDPlayerWindowManager: NSWindowController {

    var observer: Any?
    
    @IBOutlet weak var playerView: AVPlayerView!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.makeKeyAndOrderFront(self)
        window?.delegate = self
        window?.ignoresMouseEvents = true
        window?.level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(CGWindowLevelForKey(.desktopWindow)))
        window?.orderBack(self)
        window?.setFrame(NSScreen.main?.frame ?? NSMakeRect(0, 0, 0, 0), display: true, animate: false)
    }
    
    deinit {
        
        if let tmp = observer {
            NotificationCenter.default.removeObserver(tmp)
        }
    }
    
    func playVideo(_ url: URL?) {
                
        guard nil != url else {
            return
        }
        
        showWindow(self)
        
        stopVideo()
        
        if nil == observer {
            observer = NotificationCenter.default.addObserver(forName:.AVPlayerItemDidPlayToEndTime, object:nil, queue:nil, using: { [weak self] notify in
                
                self?.playerView.player?.seek(to: .zero)
                self?.playerView.player?.play()
            })
        }
        
        let player = AVPlayer(url: url!)
        self.playerView.player = player
        player.volume = 0
        
        player.play()
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

