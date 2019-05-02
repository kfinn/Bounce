import Foundation

typealias BeatInterval = Double

let BEATS_PER_MINUTE = 180.0
let BEATS_PER_SECOND = BEATS_PER_MINUTE / 60.0
let BEAT_DURATION_SECONDS = 1.0 / BEATS_PER_SECOND

extension BeatInterval {
  static func fromTimeInterval(timeInterval: TimeInterval) -> BeatInterval {
    return timeInterval / BEAT_DURATION_SECONDS
  }
  
  var timeInterval: TimeInterval {
    return self * BEAT_DURATION_SECONDS
  }
}

