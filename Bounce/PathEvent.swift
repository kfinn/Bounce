import SpriteKit

let BALL_SPEED: CGFloat = 700
let BEATS_PER_MINUTE = 180.0
let BEAT_DURATION_SECONDS = (60.0 / 180.0)

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
  let collisionTarget: SKNode?
  
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
    
    let arrhythmicTime = time + TimeInterval(nearestIntersection!.distance / BALL_SPEED)
    let rhythmicTime = max(
      round(arrhythmicTime / BEAT_DURATION_SECONDS) * BEAT_DURATION_SECONDS,
      time + BEAT_DURATION_SECONDS
    )
    return PathEvent(
      time: rhythmicTime,
      position: nearestIntersection!.point - direction.unit,
      direction: direction.reflectedAcross(normal: nearestIntersection!.normal),
      collisionTarget: nearestIntersection!.body.node
    )
  }
}
