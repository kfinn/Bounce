import SpriteKit

let BALL_SPEED: CGFloat = 1000

struct Intersection {
  let body: SKPhysicsBody
  let point: CGPoint
  let normal: CGVector
  let distance: CGFloat
}

struct PathEvent {
  let time: TimeInterval
  let position: CGPoint
  let direction: CGVector
  
  func next(ball: Ball) -> PathEvent {
    let physicsWorld = ball.scene!.physicsWorld
    var nearestIntersection: Intersection? = nil
    physicsWorld.enumerateBodies(alongRayStart: position, end: position + (direction * 10000)) { (body, point, normal, _) in
      let distance = self.position.distanceTo(point: point)
      if let nearestIntersectionDistance = nearestIntersection?.distance {
        if distance < nearestIntersectionDistance {
          nearestIntersection = Intersection(body: body, point: point, normal: normal, distance: distance)
        }
      } else {
        nearestIntersection = Intersection(body: body, point: point, normal: normal, distance: distance)
      }
    }
    
    return PathEvent(
      time: time + TimeInterval(nearestIntersection!.distance / BALL_SPEED),
      position: nearestIntersection!.point - direction.unit,
      direction: direction.reflectedAcross(normal: nearestIntersection!.normal)
    )
  }
}
