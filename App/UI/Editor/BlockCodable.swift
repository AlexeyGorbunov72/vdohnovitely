//
//  BlockCodable.swift
//  Vdohnovitely
//
//  Created by Aleksei Gorbunov on 15.07.2022.
//  Copyright © 2022 dddddjalsdjakdw. All rights reserved.
//

import Foundation
import UIKit

struct BlockCodable: Codable {
    let type: BlockCodableType
    let imageBlock: ImageBlockCodable?
    let textBlock: TextBlockCodable?
    let linkBlock: LinkBlockCodable?
}

enum BlockCodableType: String, Codable {
    case image
    case text
    case link
    case checkList
}

struct LinkBlockCodable: Codable {
    let url: URL
}

struct TextBlockCodable: Codable {
    let text: String
    let fontSize: CGFloat
}

struct ImageBlockCodable: Codable {
    let data: Data?

    init(image: UIImage) {
        self.data = image.pngData()
    }
}
