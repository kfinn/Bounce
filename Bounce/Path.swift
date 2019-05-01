import SpriteKit

struct Path {
  let start: PathEvent
  let end: PathEvent
  
  private var duration: TimeInterval {
    return end.time - start.time
  }
  
  private var positionVector: CGVector {
    return end.position - start.position
  }
  
  static func build(ball: Ball, startingAt: TimeInterval) -> Path {
    let start = PathEvent(time: startingAt, position: ball.position, direction: ball.initialDirection, collisionTarget: nil)
    let end = start.next(ball: ball)
    return Path(start: start, end: end)
  }
  
  func next(ball: Ball) -> Path {
    return Path(start: end, end: end.next(ball: ball))
  }
  
  func positionAt(timeInterval: TimeInterval) -> CGPoint {
    let proportionComplete = CGFloat((timeInterval - start.time) / duration)
    return start.position + positionVector * proportionComplete
  }
}
