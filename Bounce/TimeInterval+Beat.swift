import Foundation

extension TimeInterval {
  var beatInterval: BeatInterval {
    return BeatInterval.fromTimeInterval(timeInterval: self)
  }
}
