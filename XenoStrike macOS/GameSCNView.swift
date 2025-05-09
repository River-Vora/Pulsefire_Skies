//
//  GameSCNView.swift
//  XenoStrike macOS
//
//  Created by River Vora on 5/7/25.
//
import SceneKit

class GameSCNView: SCNView {
    
    override var acceptsFirstResponder: Bool {
        return true
    }

    override func keyDown(with event: NSEvent) {
        if let vc = self.window?.contentViewController as? GameViewController {
            vc.keyDown(with: event)
        }
    }

    override func keyUp(with event: NSEvent) {
        if let vc = self.window?.contentViewController as? GameViewController {
            vc.keyUp(with: event)
        }
    }
}

