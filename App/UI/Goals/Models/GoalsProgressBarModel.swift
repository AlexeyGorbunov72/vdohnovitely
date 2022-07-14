import Foundation
import SwiftUI
import UIKit

struct GoalsProgressBarModel {
    var timeStatuses: [GoalsTaskModel.TaskTimeStatus]
}

extension GoalsProgressBarModel {
    static let stub = GoalsProgressBarModel(
        timeStatuses: [
            .completed,
            .overtimed,
            .closeToDeadline,
            .normal
        ]
    )
}
