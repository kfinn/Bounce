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
  
  var latestTouchBeganAt: TimeInterval = 0
  var latestBallBouncedAt: TimeInterval = 0

  init(size: CGSize = CGSize.zero) {
    self.size = size
    super.init()
    self.isUserInteractionEnabled = true
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
  
  func update(from: TimeInterval, to: TimeInterval) {
    let latestTouchAgeBeats = to.beatInterval - latestTouchBeganAt.beatInterval
    if latestTouchAgeBeats < 0.5 {
      appearanceNode.fillColor = UIColor.white
    } else if latestTouchAgeBeats < 2 && latestTouchAgeBeats >= latestBallBouncedAt {
      appearanceNode.fillColor = UIColor.gray
    } else {
      appearanceNode.fillColor = UIColor.black
    }
  }
  
  func handleCollision(ball: Ball, at: TimeInterval) {
    let latestTouchAgeBeats = at.beatInterval - latestTouchBeganAt.beatInterval
    if latestTouchAgeBeats < 0.25 {
      print("latestTouchBeganAt: \(self.latestTouchBeganAt.beatInterval)\t at: \(at.beatInterval)\tbouncing (early)")
      return
    }
    run(SKAction.wait(forDuration: BeatInterval(1).timeInterval)) {
      if self.latestTouchBeganAt < at {
        print("latestTouchBeganAt: \(self.latestTouchBeganAt.beatInterval)\t at: \(at.beatInterval)\tdestroying")
        let gameScene = self.scene as! GameScene
        gameScene.destroy(ball: ball)
      } else {
        print("latestTouchBeganAt: \(self.latestTouchBeganAt.beatInterval)\t at: \(at.beatInterval)\tbouncing (late)")
        self.latestBallBouncedAt = at
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if let eventTimestamp = event?.timestamp {
      let latestTouchBeganAtBeat = latestTouchBeganAt.beatInterval
      let eventTimestampBeat = eventTimestamp.beatInterval
      if latestTouchBeganAtBeat < eventTimestampBeat - 2 || latestBallBouncedAt > latestTouchBeganAt {
        latestTouchBeganAt = eventTimestamp
      }
    }
  }
}
