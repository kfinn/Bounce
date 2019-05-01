import SpriteKit
import GameplayKit

class GameScene: SKScene {
  private var lastUpdateTime : TimeInterval?
  private var balls = [Ball]()
  
  override func sceneDidLoad() {
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    addBall(initialPosition: CGPoint(x: 100, y: 100), initialDirection: CGVector.init(dx: 2, dy: 1))
    addBall(initialPosition: CGPoint(x: 200, y: 100), initialDirection: CGVector.init(dx: 1, dy: 3))
    
    addChild({
      let obstacle = Obstacle(size: CGSize(width: 150, height: 50))
      obstacle.position = CGPoint(x: 75, y: 500)
      return obstacle
    }())
    addChild({
      let obstacle = Obstacle(size: CGSize(width: 150, height: 50))
      obstacle.position = CGPoint(x: 225, y: 500)
      return obstacle
      }())
    addChild({
      let obstacle = Obstacle(size: CGSize(width: 150, height: 50))
      obstacle.position = CGPoint(x: 75, y: 400)
      return obstacle
      }())
    addChild({
      let obstacle = Obstacle(size: CGSize(width: 150, height: 50))
      obstacle.position = CGPoint(x: 225, y: 400)
      return obstacle
      }())
    addChild({
      let obstacle = Obstacle(size: CGSize(width: 150, height: 50))
      obstacle.position = CGPoint(x: 150, y: 300)
      return obstacle
      }())
  }
  
  override func didChangeSize(_ oldSize: CGSize) {
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
  }
  
  func addBall(initialPosition: CGPoint, initialDirection: CGVector) {
    let ball = Ball(initialDirection: initialDirection)
    ball.position = initialPosition
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
