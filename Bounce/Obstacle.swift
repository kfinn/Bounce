import Foundation

protocol Obstacle {
  func handleCollision(ball: Ball, at: TimeInterval)
}
