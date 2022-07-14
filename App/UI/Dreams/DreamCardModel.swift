//
//  DreamCardModel.swift
//  Vdohnovitely
//
//  Created by Danil Dubov on 14.07.2022.
//  Copyright © 2022 dddddjalsdjakdw. All rights reserved.
//

import Foundation
import UIKit

struct DreamCardModel: Identifiable {
    var id: Int

    var name: String
    var image: UIImage?
}

extension DreamCardModel {
    static let stub = DreamCardModel(
        id: 1,
        name: "Побывать во всех странах Европы Побывать во всех странах Европы Побывать во всех странах Европы",
        image: nil
    )

    static let stub2 = DreamCardModel(
        id: 2,
        name: "Побывать во всех странах Европы",
        image: nil
    )

    static let stub3 = DreamCardModel(
        id: 3,
        name: "Побывать во всех странах Европы",
        image: nil
    )
}
