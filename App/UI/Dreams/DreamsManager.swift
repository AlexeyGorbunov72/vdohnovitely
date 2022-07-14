import Foundation
import Combine


final class DreamsManager {
  static let shared = DreamsManager()
  private init() {}

  enum Event {
    case tapOnCard(Int)
  }

  let publisher = PassthroughSubject<Event, Never>()
}
