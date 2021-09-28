//
//  main.swift
//  vWall
//
//  Created by Sword on 2021/9/27.
//

import Cocoa

// let _ = NSApplication.shared
// let delegate = AppDelegate()
// NSApplication.shared.delegate = delegate

let app = NSApplication.shared
let appDelegate = AppDelegate()
app.delegate = appDelegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

