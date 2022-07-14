import Foundation
import SwiftUI
import UIKit

struct GoalsCardModel: Identifiable {
    let id: Int
    let name: String
    let createDate: String
    let tasks: [GoalsTaskModel]
}

extension GoalsCardModel {
    var progressBarModel: GoalsProgressBarModel {
        GoalsProgressBarModel(timeStatuses: self.tasks.map{ $0.taskTimeStatus } )
    }
}

extension GoalsCardModel {
    static let stub = GoalsCardModel(
        id: 1,
        name: "100 Отжиманий до 5 июля",
        createDate: "14.06",
        tasks: [
            .stub1,
            .stub2,
            .stub3,
            .stub4
        ]
    )

    static let stub2 = GoalsCardModel(
        id: 2,
        name: "100 Отжиманий до 5 июля",
        createDate: "14.06",
        tasks: [
            .stub1,
            .stub2,
            .stub3,
            .stub4,
            .stub1,
            .stub2,
            .stub3,
            .stub4
        ]
    )
}

