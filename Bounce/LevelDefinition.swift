import CoreGraphics

struct BallDefinition: Decodable {
  let initialPosition: CGPoint
  let initialDirection: CGVector
}

struct BrickDefinition: Decodable {
  let position: CGPoint
  let size: CGSize
}

struct LevelDefinition: Decodable {
  let balls: [BallDefinition]
  let bricks: [BrickDefinition]
}
