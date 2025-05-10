//
//  GameViewController.swift
//  TestSceneKitSwift macOS
//
//  Created by River Vora on 4/20/25.
//

import Cocoa
import SceneKit

class GameViewController: NSViewController {

    var gameView: GameSCNView {
        return self.view as! GameSCNView
    }

    var gameController: GameController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gameController = GameController(sceneRenderer: gameView)
        print("✅ GameController initialized in GameViewController")

        gameView.allowsCameraControl = true
        gameView.backgroundColor = .blue

        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        gameView.gestureRecognizers.insert(clickGesture, at: 0)

        //print("🎥 Renderer delegate: \(gameView.delegate ?? "None")")
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.makeFirstResponder(self)
        print("✅ GameViewController became first responder")
    }

    @objc func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        // Optional: handle mouse clicks
    }

    override func keyDown(with event: NSEvent) {
        print("⬇️ Key down: \(event.keyCode)")
        handleKey(event.keyCode, isDown: true)
    }

    override func keyUp(with event: NSEvent) {
        print("⬆️ Key up: \(event.keyCode)")
        handleKey(event.keyCode, isDown: false)
    }

    func handleKey(_ keyCode: UInt16, isDown: Bool) {
        Task { @MainActor in
            if isDown {
                gameController.keysPressed.insert(keyCode)
                print("🔑 Key pressed: \(keyCode), keysPressed: \(gameController.keysPressed)")
            } else {
                gameController.keysPressed.remove(keyCode)
                print("🔑 Key released: \(keyCode), keysPressed: \(gameController.keysPressed)")
            }
        }
    }

    override var acceptsFirstResponder: Bool { true }
    override func becomeFirstResponder() -> Bool { true }
}
