import SceneKit

#if os(macOS)
typealias SCNColor = NSColor
#else
typealias SCNColor = UIColor
#endif

@MainActor
class GameController: NSObject, SCNSceneRendererDelegate {

    @MainActor var keysPressed: Set<UInt16> = []
    private var previousUpdateTime: TimeInterval? // Added property to track previous update time

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
            let deltaTime = time - (previousUpdateTime ?? time) // Calculate deltaTime
            previousUpdateTime = time // Update the stored time
            self.performShipActions(deltaTime: deltaTime)
        }
    }

    @MainActor
    func performShipActions(deltaTime: TimeInterval) {
        guard let ship = shipNode else { return }

        var movement = SCNVector3Zero
        var rotationY: CGFloat = 0.0

        let moveSpeed: CGFloat = 2.0 * CGFloat(deltaTime) // Increased move speed
        let rotationSpeed: CGFloat = 0.1 * CGFloat(deltaTime) // Increased rotation speed

        if keysPressed.contains(13) { // W
            movement.z -= moveSpeed
        }
        if keysPressed.contains(1) { // S
            movement.z += moveSpeed
        }
        if keysPressed.contains(0) { // A
            rotationY += rotationSpeed
        }
        if keysPressed.contains(2) { // D
            rotationY -= rotationSpeed
        }

        if movement != SCNVector3Zero { // Custom != operator for SCNVector3
            let direction = ship.presentation.convertVector(movement, to: nil)
            ship.position += direction
            print("🚀 Ship moved to position: \(ship.position)")
        }

        if rotationY != 0 {
            ship.eulerAngles.y += rotationY
            print("🔄 Ship rotated to angle: \(ship.eulerAngles.y)")
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
