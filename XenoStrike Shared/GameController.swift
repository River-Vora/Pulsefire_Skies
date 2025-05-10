import SceneKit

#if os(macOS)
typealias SCNColor = NSColor
#else
typealias SCNColor = UIColor
#endif

@MainActor
class GameController: NSObject, SCNSceneRendererDelegate {

    @MainActor var keysPressed: Set<UInt16> = []
    private var previousUpdateTime: TimeInterval?

    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    @MainActor var shipNode: SCNNode?

    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/ship2.scn")!

        if let groundScene = SCNScene(named: "Art.scnassets/ground.scn") {
            for child in groundScene.rootNode.childNodes {
                scene.rootNode.addChildNode(child)
            }
            print("✅ Ground scene loaded with \(groundScene.rootNode.childNodes.count) child nodes")
        }

        shipNode = scene.rootNode.childNode(withName: "ship", recursively: true)
        if shipNode == nil {
            print("⚠️ Could not find ship node named 'ship'")
        } else {
            print("✅ Ship node found: \(shipNode!)")
        }

        super.init()

        sceneRenderer.delegate = self
        sceneRenderer.scene = scene
        print("✅ GameController initialized")
    }

    nonisolated func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Task { @MainActor in
            let deltaTime = time - (previousUpdateTime ?? time)
            previousUpdateTime = time
            print("⏱️ deltaTime: \(deltaTime)")
            self.performShipActions(deltaTime: deltaTime)
        }
    }

    @MainActor
    func performShipActions(deltaTime: TimeInterval) {
        guard let ship = shipNode else {
            print("❌ Ship node is nil")
            return
        }

        print("⏱️ Performing ship actions, keysPressed: \(keysPressed)")

        var movement = SCNVector3Zero
        var rotationY: CGFloat = 0.0

        let moveSpeed: CGFloat = 20.0 * CGFloat(deltaTime) // Temporarily increased speed
        let rotationSpeed: CGFloat = 5.0 * CGFloat(deltaTime) // Temporarily increased rotation

        if keysPressed.contains(13) { // W
            movement.z -= moveSpeed
            print("⬆️ Moving forward, movement: \(movement), keysPressed: \(keysPressed)")
        } else {
            print("❌ W key not detected in keysPressed: \(keysPressed)")
        }

        if keysPressed.contains(1) { // S
            movement.z += moveSpeed
            print("⬇️ Moving backward, movement: \(movement), keysPressed: \(keysPressed)")
        } else {
            print("❌ S key not detected in keysPressed: \(keysPressed)")
        }

        if keysPressed.contains(0) { // A
            rotationY += rotationSpeed
            print("⬅️ Rotating left, rotationY: \(rotationY), keysPressed: \(keysPressed)")
        } else {
            print("❌ A key not detected in keysPressed: \(keysPressed)")
        }

        if keysPressed.contains(2) { // D
            rotationY -= rotationSpeed
            print("➡️ Rotating right, rotationY: \(rotationY), keysPressed: \(keysPressed)")
        } else {
            print("❌ D key not detected in keysPressed: \(keysPressed)")
        }

        if movement != SCNVector3Zero {
            let direction = ship.presentation.convertVector(movement, to: nil)
            ship.position += direction
            print("🚀 Ship moved to position: \(ship.position)")
        } else {
            print("❌ No movement detected")
        }

        if rotationY != 0 {
            ship.eulerAngles.y += rotationY
            print("🔄 Ship rotated to angle: \(ship.eulerAngles.y)")
        } else {
            print("❌ No rotation detected")
        }
    }
}

// MARK: - SCNVector3 Comparison Helpers

extension SCNVector3 {
    static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    static func != (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return !(lhs == rhs)
    }
}

// MARK: - Vector Math Helpers

func + (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    return SCNVector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

func += (lhs: inout SCNVector3, rhs: SCNVector3) {
    lhs = lhs + rhs
}
