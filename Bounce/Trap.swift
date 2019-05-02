import SpriteKit

class Trap: SKNode, Obstacle {
  lazy var appearanceNode: SKShapeNode = {
    let appearanceNode = SKShapeNode(rectOf: size)
    appearanceNode.fillColor = UIColor.black
    appearanceNode.strokeColor = UIColor.lightGray
    return appearanceNode
  }()

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

  init(size: CGSize = CGSize.zero) {
    self.size = size
    super.init()
    physicsBody = {
      let physicsBody = SKPhysicsBody(rectangleOf: size)
      physicsBody.isDynamic = false
      return physicsBody
    }()
    addChild(appearanceNode)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func handleCollision(ball: Ball) {
    let gameScene = scene as! GameScene
    gameScene.destroy(ball: ball)
  }
}
