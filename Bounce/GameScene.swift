import SpriteKit
import GameplayKit

class GameScene: SKScene {
  private var lastUpdateTime : TimeInterval?
  private var balls = [Ball]()
  
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
    level.obstacles.forEach { (obstacleDefinition) in
      let obstacle = Obstacle(size: obstacleDefinition.size)
      obstacle.position = obstacleDefinition.position
      addChild(obstacle)
    }    
  }
  
  override func didChangeSize(_ oldSize: CGSize) {
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
  }
  
  func add(ball: Ball) {
    addChild(ball)
    balls.append(ball)
  }
  
  override func update(_ currentTime: TimeInterval) {
    if let from = lastUpdateTime {
      balls.forEach { (ball) in
        ball.update(from: from, to: currentTime)
      }
    }
    self.lastUpdateTime = currentTime
  }
}
