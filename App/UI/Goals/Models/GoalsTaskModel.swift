import Foundation
import SwiftUI
import UIKit

struct GoalsTaskModel: Identifiable {
    enum TaskTimeStatus: Identifiable {
        var id: UUID { UUID() }

        case completed
        case normal
        case overtimed
        case closeToDeadline
    }

    let id: Int
    let name: String
    let deadLineDate: String?
    let taskTimeStatus: TaskTimeStatus
    var isCompleted: Bool
}

extension GoalsTaskModel.TaskTimeStatus {
    var sectionColor: Color {
        switch self {
        case .completed:
          return Color(VdohnovitelyAsset.goalsCardGreenColor.color)
        case .normal:
          return Color(VdohnovitelyAsset.goalsCardNormalColor.color)
        case .overtimed:
          return Color(VdohnovitelyAsset.goalsCardRedColor.color)
        case .closeToDeadline:
          return Color(VdohnovitelyAsset.goalsCardOrangeColor.color)
        }
    }
}

extension GoalsTaskModel {
    static let stub1 = GoalsTaskModel(
        id: 1,
        name: "10 отжиманий",
        deadLineDate: "19.06",
        taskTimeStatus: .completed,
        isCompleted: true
    )

    static let stub2 = GoalsTaskModel(
        id: 2,
        name: "30 отжиманий",
        deadLineDate: "3.07",
        taskTimeStatus: .overtimed,
        isCompleted: false
    )

    static let stub3 = GoalsTaskModel(
        id: 3,
        name: "40 отжиманий",
        deadLineDate: "4.07",
        taskTimeStatus: .closeToDeadline,
        isCompleted: false
    )

    static let stub4 = GoalsTaskModel(
        id: 4,
        name: "100 отжиманий",
        deadLineDate: "5.07",
        taskTimeStatus: .normal,
        isCompleted: false
    )
}
