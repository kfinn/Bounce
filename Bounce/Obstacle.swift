import SpriteKit

class Obstacle: SKNode {
  let appearanceNode: SKShapeNode = {
    let appearanceNode = SKShapeNode(rectOf: CGSize.zero)
    appearanceNode.fillColor = UIColor.black
    appearanceNode.strokeColor = UIColor.lightGray
    return appearanceNode
  }()
  
  var size: CGSize {
    didSet {
      appearanceNode.path = CGPath.init(rect: CGRect(origin: CGPoint.zero, size: size), transform: nil)
    }
  }
  
  init(size: CGSize = CGSize.zero) {
    self.size = size
    super.init()
    addChild(appearanceNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(from: TimeInterval, to: TimeInterval) {
    
  }
}
