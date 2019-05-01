import CoreGraphics

struct BallDefinition: Decodable {
  let initialPosition: CGPoint
  let initialDirection: CGVector
}

struct ObstacleDefinition: Decodable {
  let position: CGPoint
  let size: CGSize
}

struct LevelDefinition: Decodable {
  let balls: [BallDefinition]
  let obstacles: [ObstacleDefinition]
}
