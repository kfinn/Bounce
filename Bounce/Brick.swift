import SpriteKit

class Brick: SKNode, Obstacle {
  lazy var appearanceNode: SKShapeNode = {
    let appearanceNode = SKShapeNode(rectOf: size)
    appearanceNode.fillColor = UIColor.black
    appearanceNode.strokeColor = UIColor.lightGray
    return appearanceNode
  }()
  
  lazy var healthNode = SKLabelNode(text: "\(health)")
  
  var size: CGSize {
    didSet {
      appearanceNode.path = CGPath(rect: CGRect(origin: CGPoint.zero, size: size), transform: nil)
      physicsBody = {
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.isDynamic = false
        return physicsBody
      }()
    }
  }
  
  var health = 10 {
    didSet {
      healthNode.text = "\(health)"
    }
  }
  
  init(size: CGSize = CGSize.zero) {
    self.size = size
    super.init()
    physicsBody = {
      let physicsBody = SKPhysicsBody(rectangleOf: size)
      physicsBody.isDynamic = false
      return physicsBody
    }()
    addChild(appearanceNode)
    addChild(healthNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func handleCollision(ball: Ball, at: TimeInterval) {
    health -= 1
    
    if health <= 0 {
      removeFromParent()
    }
  }
}
