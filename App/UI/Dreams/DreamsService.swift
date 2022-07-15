import Foundation
import SwiftUI
import LinkPresentation

class DreamsService {
    let userDefaults = UserDefaults.standard

    func saveDream(block: [BlockCodable]) {
        var dreams = userDefaults.dreams.value ?? []
        dreams.append(block)
        userDefaults.dreams.value = dreams
    }

    func getDream() -> [Block] {
        var dreams = userDefaults.dreams.value ?? []

        let c = dreams.first!.reduce(into: [Block]()) { arr, block in
            arr.append(BlockMapper.map(block: block))
        }

        return c
    }

    func getAll() -> [[Block]] {
        var dreams = userDefaults.dreams.value ?? []

        return dreams.reduce(into: [[Block]]()) { arr, block in
            arr.append(block.reduce(into: [Block]()){ arrr, blockk in arrr.append(BlockMapper.map(block: blockk)) })
        }
    }
}

enum BlockMapper {
    static func map(block: Block) -> BlockCodable {
        switch block.typeBlock {
        case .text:
            return BlockCodable(
                type: .text,
                imageBlock: nil,
                textBlock: TextBlockCodable(text: block.textBlock.text.string, fontSize: block.textBlock.font.pointSize),
                linkBlock: nil
            )

        case .image:
            return BlockCodable(
                type: .image,
                imageBlock: ImageBlockCodable(image: block.imageBlock.image),
                textBlock: nil,
                linkBlock: nil
            )

        case .link:
            return BlockCodable(
                type: .link,
                imageBlock: nil,
                textBlock: nil,
                linkBlock: LinkBlockCodable(url: block.linksBlock.metadata.url!)
            )

        case .checklist:
            break
        }
        fatalError()
    }

    static func map(block: BlockCodable) -> Block {
        switch block.type {
        case .text:
            return Block(
                blockType: .text(TextBlock(text: NSAttributedString(string: block.textBlock?.text ?? ""), font: UIFont.systemFont(ofSize: block.textBlock!.fontSize)))
                )

        case .link:
            let group = DispatchGroup()
            group.enter()
            var metaadata: LPLinkMetadata?
            LPMetadataProvider().startFetchingMetadata(for: block.linkBlock!.url) { (metadata, error) in
                metaadata = metadata
                group.leave()
            }
            group.wait()
            return Block(blockType: .link(LinkBlock(metadata: metaadata!)))

        case .image:
            return Block(blockType: .image(ImageBlock(image: UIImage(data: block.imageBlock!.data!)!)))

        case .checkList:
            break
        }
        fatalError()
    }
}

extension UserDefaults {
    var dreams: KeyValueContainer<[[BlockCodable]]> { make() }
}
