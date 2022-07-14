import Combine
import Foundation

class TabBar: ObservableObject {
  enum Event {
    case curiosity
    case dream
    case goal
  }

  enum TapIcon {
    case tapCuriosity
    case tapGoal
    case tapDream
  }

  static let shared = TabBar()
  private init() {}

  let publisher = PassthroughSubject<Event, Never>()

  @Published var curiosityVisible: Bool = true
  @Published var goalVisible: Bool = false
  @Published var dreamVisible: Bool = false

  func taped(_ event: TapIcon) {
    switch event {
    case .tapCuriosity:
      curiosityVisible = true
      goalVisible = false
      dreamVisible = false
    case .tapGoal:
      goalVisible = true
      curiosityVisible = false
      dreamVisible = false
    case .tapDream:
      dreamVisible = true
      goalVisible = false
      curiosityVisible = false
    }
  }
}
