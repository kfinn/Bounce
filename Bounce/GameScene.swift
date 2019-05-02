import SpriteKit
import GameplayKit

class GameScene: SKScene {
  private var lastUpdateTime : TimeInterval?
  private var balls = [Ball]()
  private lazy var trap = Trap()
  
  override func sceneDidLoad() {
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    let levelURL = Bundle.main.url(forResource: "Level1", withExtension: "json")!
    let levelData = try! Data(contentsOf: levelURL)
    let level = try! JSONDecoder().decode(LevelDefinition.self, from: levelData)
    
    level.balls.forEach { (ballDefinition) in
      let ball = Ball(initialDirection: ballDefinition.initialDirection)
      ball.position = ballDefinition.initialPosition
      add(ball: ball)
    }
    level.bricks.forEach { (brickDefinition) in
      let brick = Brick(size: brickDefinition.size)
      brick.position = brickDefinition.position
      addChild(brick)
    }
    addChild(trap)
  }
  
  override func didChangeSize(_ oldSize: CGSize) {
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    self.trap.size = CGSize(width: self.size.width, height: 80)
    self.trap.position = CGPoint(x: 0, y: 0)
  }
  
  func add(ball: Ball) {
    addChild(ball)
    balls.append(ball)
  }
  
  func destroy(ball: Ball) {
    ball.removeFromParent()
    balls.removeAll { ball == $0 }
  }
  
  override func update(_ currentTime: TimeInterval) {
    if let from = lastUpdateTime {
      balls.forEach { (ball) in
        ball.update(from: from, to: currentTime)
      }
      trap.update(from: from, to: currentTime)
    }
    self.lastUpdateTime = currentTime
  }
}
