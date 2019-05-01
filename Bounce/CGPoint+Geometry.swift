import CoreGraphics

extension CGPoint {
  static func +(point: CGPoint, vector: CGVector) -> CGPoint {
    return CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
  }
  
  static func -(point: CGPoint, vector: CGVector) -> CGPoint {
    return point + (-vector)
  }
  
  static func +=(point: inout CGPoint, vector: CGVector) {
    point = point + vector
  }
  
  static func -(lhs: CGPoint, rhs: CGPoint) -> CGVector {
    return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
  }
  
  func distanceTo(point: CGPoint) -> CGFloat {
    return (self - point).length
  }
}
