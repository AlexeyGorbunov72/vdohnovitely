import Foundation
import UIKit
import LinkPresentation

class Block: Identifiable {
    let id: UUID

    enum `Type` {
        case text
        case image
        case checklist
        case link
    }

    @Published var textBlock: TextBlock!
    @Published var imageBlock: ImageBlock!
    @Published var checklistBlock: ChecklistBlock!
    @Published var linksBlock: LinkBlock!

    var typeBlock: Block.`Type` = .image

    init(id: UUID = UUID(), blockType: BlockType) {
        self.id = id

        switch blockType {
        case .text(let textBlock):
            self.textBlock = textBlock
            self.typeBlock = .text

        case .image(let imageBlock):
            self.imageBlock = imageBlock
            self.typeBlock = .image

        case .checklist(let checklistBlock):
            self.checklistBlock = checklistBlock
            self.typeBlock = .checklist

        case .link(let linkBlock):
            self.typeBlock = .link
            self.linksBlock = linkBlock
        }
    }
}

enum BlockType {

    case text(TextBlock)
    case image(ImageBlock)
    case checklist(ChecklistBlock)
    case link(LinkBlock)
}

struct ImageBlock {

    let image: UIImage

    init(image: UIImage) {
        self.image = image
    }
}

struct LinkBlock {

    let metadata: LPLinkMetadata
}

class ChecklistBlock {
    let points: [ChecklistItem]

    init(points: [ChecklistItem]) {
        self.points = points
    }
}

struct ChecklistItem: Identifiable {
    let id: UUID
    let text: TextBlock
    let isDone: Bool

    init(id: UUID, text: TextBlock, isDone: Bool) {
        self.id = id
        self.text = text
        self.isDone = isDone
    }
}

struct TextBlock {

    let text: NSAttributedString
    let isResponder: Bool
    let font: UIFont

    init(text: NSAttributedString, isResponder: Bool = false, font: UIFont) {
        self.text = text
        self.isResponder = isResponder
        self.font = font
    }
}
