import SpriteKit

let BALL_RADIUS: CGFloat = 10

class Ball: SKNode {
  static let BOUNCE_SOUND_ACTION = SKAction.playSoundFileNamed("kick", waitForCompletion: false)
  
  let appearanceNode: SKNode = {
    let appearanceNode = SKShapeNode(circleOfRadius: BALL_RADIUS)
    appearanceNode.fillColor = UIColor.black
    appearanceNode.strokeColor = UIColor.white
    return appearanceNode
  }()
  
  var initialDirection: CGVector
  var path: Path?
  
  init(initialDirection: CGVector) {
    self.initialDirection = initialDirection
    super.init()
    addChild(appearanceNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(from: TimeInterval, to: TimeInterval) {
    var collisions = [Obstacle]()
    if path == nil {
      path = Path.build(ball: self, startingAt: to)
    } else if path!.end.time < to {
      run(Ball.BOUNCE_SOUND_ACTION)
      while path!.end.time < to {
        if let obstacle = path!.end.collisionTarget as? Obstacle {
          collisions.append(obstacle)
        }
        path = path!.next(ball: self)
      }
    }
    
    collisions.forEach { $0.handleCollision(ball: self) }
    position = path!.positionAt(timeInterval: to)
  }
}
