import SpriteKit
import GameplayKit

class GameScene: SKScene {
  private var lastUpdateTime : TimeInterval = 0
  
  override func sceneDidLoad() {
    let shapeNode = SKShapeNode(circleOfRadius: 100)
    shapeNode.strokeColor = UIColor.white
    shapeNode.position = CGPoint(x: 100, y: 100)
    addChild(shapeNode)
  }
  
  override func update(_ currentTime: TimeInterval) {
    if (self.lastUpdateTime == 0) {
      self.lastUpdateTime = currentTime
    }
    
    self.lastUpdateTime = currentTime
  }
}
