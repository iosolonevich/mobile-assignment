//
//  RocketSpriteScene.swift
//  SpaceXExplorer
//
//  Created by alex on 14.11.2021.
//

import Foundation
import SpriteKit
import CoreMotion

class RocketScene: SKScene {
    
    private let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0.0
    var yAcceleration: CGFloat = 0.0
    
    private var backgroundNode: SKNode!
    private var midgroundNode: SKNode!
    private var foregroundNode: SKNode!
    private var rocketNode: SKNode!
    private var hudNode: SKNode!
    private var tapToLaunchNode: SKNode!
        
    override init(size: CGSize) {
        super.init(size: size)

        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        backgroundNode = createBackgroundNode()
        addChild(backgroundNode)
        
        midgroundNode = createMidgroundNode()
        addChild(midgroundNode)
        
        foregroundNode = SKNode()
        addChild(foregroundNode)
        
        hudNode = SKNode()
        addChild(hudNode)
        
        tapToLaunchNode = createTapToLaunchNode()
        hudNode.addChild(tapToLaunchNode)
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
            if let acceleration = accelerometerData?.acceleration {
                self.xAcceleration = (CGFloat(acceleration.x) * 0.75) + (self.xAcceleration * 0.25)
                self.yAcceleration = (CGFloat(acceleration.y) * 0.75) + (self.xAcceleration * 0.25)
            }
        }
        
        rocketNode = createRocket()
        foregroundNode.addChild(rocketNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if rocketNode.position.y > 300.0 {
            midgroundNode.position = CGPoint(x: 0.0, y: -((rocketNode.position.y - 300.0)))
            foregroundNode.position = CGPoint(x: 0.0, y: -(rocketNode.position.y - 300.0))
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let physics = rocketNode.physicsBody, physics.isDynamic {
            return
        }

        tapToLaunchNode.removeFromParent()
        
        rocketNode.physicsBody?.isDynamic = true
        rocketNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
    }

    private func createBackgroundNode() -> SKNode {
        let backgroundNode = SKNode()
        
        let node = SKSpriteNode(
            color: UIColor(red: 155/255, green: 200/255, blue: 255/255, alpha: 1.0),
            size: self.size)
        node.setScale(2.0)
        
        backgroundNode.addChild(node)
        return backgroundNode
    }
    
    private func createMidgroundNode() -> SKNode {
        let midgroundNode = SKNode()
        var anchor: CGPoint!
        var xPosition: CGFloat!
        
        for index in 0...9 {
            var spriteName: String
            let r = Int.random(in: 0...2)
            switch r {
            case 0:
                spriteName = "Cloud1"
                anchor = CGPoint(x: 1.0, y: 0.5)
                xPosition = self.size.width
            case 1:
                spriteName = "Cloud2"
                anchor = CGPoint(x: 0.0, y: 0.5)
                xPosition = 0.0
            default:
                spriteName = "Cloud3"
                anchor = CGPoint(x: self.size.width / 2, y: 0.5)
                xPosition = self.size.width / 2
            }
            
            let cloudNode = SKSpriteNode(imageNamed: spriteName)
            cloudNode.anchorPoint = anchor
            cloudNode.position = CGPoint(x: xPosition, y: 300.0 * CGFloat(index))
            
            cloudNode.setScale(Double.random(in: 0.1...1.3))

            midgroundNode.addChild(cloudNode)
        }

        return midgroundNode
    }
    
    private func createTapToLaunchNode() -> SKNode {
        let circleBackgroundNode = SKShapeNode(circleOfRadius: 100)
        circleBackgroundNode.fillColor = .white
        circleBackgroundNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        circleBackgroundNode.addChild(createTapToLaunchLabelNode())
        
        return circleBackgroundNode
    }
    
    private func createTapToLaunchLabelNode() -> SKLabelNode {
        let labelNode = SKLabelNode(fontNamed: "Arial")
        labelNode.numberOfLines = 2
        labelNode.text = """
    TAP
to launch!
"""
        labelNode.fontColor = UIColor.systemPink
        labelNode.verticalAlignmentMode = .center
        labelNode.fontSize = 30.0
        labelNode.zPosition = 1
        
        return labelNode
    }
    
    private func createRocket() -> SKNode {
        let rocketNode = SKNode()
        rocketNode.position = CGPoint(x: self.size.width / 2, y: 150)
        
        let sprite = SKSpriteNode(imageNamed: "Rocket Idle")
        rocketNode.addChild(sprite)
        
        rocketNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        rocketNode.physicsBody?.isDynamic = false
        rocketNode.physicsBody?.allowsRotation = true
        rocketNode.physicsBody?.friction = 0.0
        rocketNode.physicsBody?.angularDamping = 0.0
        rocketNode.physicsBody?.linearDamping = 0.0
        
        return rocketNode
    }
    
    override func didSimulatePhysics() {
        rocketNode.physicsBody?.velocity = CGVector(dx: xAcceleration * 700.0, dy: yAcceleration * 700.0)
        
        if rocketNode.position.x < -50.0 {
            rocketNode.position = CGPoint(x: self.size.width + 50.0, y: rocketNode.position.y)
        } else if rocketNode.position.x > self.size.width + 50.0 {
            rocketNode.position = CGPoint(x: -50.0, y: rocketNode.position.y)
        }
    }
}
