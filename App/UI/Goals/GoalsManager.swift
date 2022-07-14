import Foundation
import Combine

final class GoalsManager {
  static let shared = GoalsManager()
  private init() {}

  enum Event {
    case tapOnCard(Int)
    case tapOnTask(Int)
  }

  let publisher = PassthroughSubject<Event, Never>()
}
