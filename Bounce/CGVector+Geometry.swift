import CoreGraphics

extension CGVector {
  static func *(vector: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
  }
  
  static func /(vector: CGVector, scalar: CGFloat) -> CGVector {
    return vector * (1.0 / scalar)
  }
  
  static func *(left: CGVector, right: CGVector) -> CGFloat {
    return left.dx * right.dx + left.dy * right.dy
  }
  
  static func -(left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
  }
  
  static prefix func -(vector: CGVector) -> CGVector {
    return CGVector(dx: -vector.dx, dy: -vector.dy)
  }
  
  var length: CGFloat {
    return sqrt(dx * dx + dy * dy)
  }
  
  func reflectedAcross(normal: CGVector) -> CGVector {
    // https://math.stackexchange.com/questions/13261/how-to-get-a-reflection-vector
    return self - normal.unit * (2 * (self * normal.unit))
  }
  
  var unit: CGVector {
    return self / self.length
  }
}
