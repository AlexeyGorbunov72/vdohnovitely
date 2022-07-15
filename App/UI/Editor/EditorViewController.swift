import Foundation
import UIKit
import SwiftUI
import LinkPresentation

class Blocks: ObservableObject {
    @Published var blocks: [Block] = []
}

final class EditorViewController: UIViewController, UIAdaptivePresentationControllerDelegate, ImagePickerDelegate {
    var swiftuiView: UIHostingController<EditorView>?
    var selectedBlockID: UUID!
    var blocks: Blocks!
    var textFormattingView: HateVc?

    override func viewDidLoad() {
        super.viewDidLoad()
        let blocks = makeBlocks()

        let swiftuiView = UIHostingController(
           rootView: EditorView(
            blocks: blocks,
            onTextFormattingTapped: showTextFormattion,
            onListTapped: addChecklist,
            onCapturePhoto: capturePhoto,
            onSelectPhoto: selectPhoto,
            onBackgroundTapped: onBakgroundTapped,
            onSelectBlock: onSelectBlock,
            onEmptyDelete: deleteBlock,
            onURLSFind: onURLSFind
           )
        )
        selectedBlockID = blocks.blocks.first!.id
        add(swiftuiView)
        swiftuiView.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    var imagePicker: ImagePicker!
    private func capturePhoto() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        imagePicker.present(from: view, with: .camera, onPresent: nil)
        
    }
    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        blocks.blocks.append(Block(blockType: .image(ImageBlock(image: image))))
    }
    private func selectPhoto() {
        UIApplication.shared.endEditing()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        imagePicker.present(from: view, with: .photoLibrary, onPresent: { UIApplication.shared.endEditing() })
    }

    private var addedURLS = Set<URL>()

    private func onURLSFind(_ id: UUID, _ urls: [URL]) {

        urls.forEach { url in
            guard !addedURLS.contains(url) else { return }
            addedURLS.insert(url)
            LPMetadataProvider().startFetchingMetadata(for: url) { (metadata, error) in
                guard let data = metadata, error == nil else {
                    return
                }

                DispatchQueue.main.async {
                    self.blocks.blocks.append(Block(blockType: .link(LinkBlock(metadata: data))))
                }
            }
        }
        eraseURLFromBlock(with: id)
    }

    private func eraseURLFromBlock(with id: UUID) {
        guard let input = blocks.blocks.first(where: { $0.id == id }) else { return }
        let text = input.textBlock.text.string
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        var urls = [URL]()
        var newString = NSMutableAttributedString(attributedString: input.textBlock.text)

        let trimmedString = text.replacingOccurrences(of: "https?://\\S+\\b", with: "", options: .regularExpression)
        guard let  index = blocks.blocks.firstIndex(where: { $0.id == id }) else { return }
        if trimmedString.isEmpty {
            blocks.blocks.remove(at: index)
            guard let idd = blocks.blocks.lastIndex(where: { $0.typeBlock == .text }) else { return }
            onSelectBlock(blocks.blocks[idd].id)
            return
        }
        blocks.blocks[index] = Block(
            id: id,
            blockType: .text(TextBlock(text: NSAttributedString(string: trimmedString), isResponder: true, font: blocks.blocks[index].textBlock.font))
        )
//        for match in matches {
//            guard let range = Range(match.range, in: text) else { continue }
//            newString.deleteCharacters(in: String().nsRange(from: range))
//            eraseURLFromBlock(with: id)
//        }
        
    }

    private func onSelectBlock(_ id: UUID) {
        selectedBlockID = id
        let a = blocks.blocks.map { block -> Block in
            guard block.typeBlock == .text else { return block }
            let text = block.textBlock.text
            return Block(
                id: block.id,
                blockType: .text(TextBlock(text: text, isResponder: block.id == id ? true : false, font: block.textBlock.font))
            )
        }
        blocks.blocks = a
    }

    private func makeBlocks() -> Blocks {
        let blocks = Blocks()

        blocks.blocks = [
            Block(blockType: .text(TextBlock(text: NSAttributedString(""), isResponder: true, font: UIFont.preferredFont(forTextStyle: .largeTitle))))
        ]
        self.blocks = blocks
        return blocks
    }

    private func onBakgroundTapped() {
        guard let block = blocks.blocks.first(where: { $0.id == selectedBlockID }) else { return }
        guard block.textBlock.text.length > 0 else { return }

        let newBlock = Block(blockType: .text(.init(text: NSAttributedString(string: ""), isResponder: true, font: UIFont.preferredFont(forTextStyle: .footnote)
)))

        blocks.blocks.append(newBlock)
        onSelectBlock(newBlock.id)
    }

    private func showTextFormattion() {
        let textFormattingView = HateVc()
        textFormattingView.onFinish = {
            self.onSelectBlock(self.selectedBlockID)
        }
        textFormattingView.$styles
            .sink {
                print($0)
            }
            .store(in: &textFormattingView.disposable)

        textFormattingView.$selectedFont.sink {
            guard let block = self.blocks.blocks.firstIndex(where: { $0.id == self.selectedBlockID }) else { return }

            let blockk = Block(
                id: self.blocks.blocks[block].id,
                blockType: .text(
                    TextBlock(
                        text: self.blocks.blocks[block].textBlock.text,
                        isResponder: false,
                        font: UIFont.preferredFont(from: $0)
                    )
                )
            )
            self.blocks.blocks.remove(at: block)
            self.blocks.blocks.insert(blockk, at: block)
           
        }
        .store(in: &textFormattingView.disposable)
        self.textFormattingView = textFormattingView
        UIApplication.shared.endEditing()
        let nav = MyNVC(rootViewController: textFormattingView)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        nav.navigationBar.isHidden = true
        textFormattingView.presentationController?.delegate = self
        nav.presentationController?.delegate = self
        present(nav, animated: true, completion: {UIApplication.shared.endEditing()})

    }

    public func presentationControllerDidDismiss(
      _ presentationController: UIPresentationController)
    {
        self.onSelectBlock(self.selectedBlockID)
    }

    private func addChecklist() {
        
    }

    private func deleteBlock(_ id: UUID) {
        blocks.blocks.removeAll(where: { $0.id == id })
        var lastIndex: UUID?

        blocks.blocks.forEach { block in
            guard block.typeBlock == .text else { return }
            lastIndex = block.id
        }
        guard let index = lastIndex else { return }
        onSelectBlock(index)
    }
}

class MyNVC: UINavigationController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension UIFont {
    class func preferredFont(from font: Font) -> UIFont {
        let uiFont: UIFont
        
        switch font {
        case .largeTitle:
            uiFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        case .title:
            uiFont = UIFont.preferredFont(forTextStyle: .title1)
        case .title2:
            uiFont = UIFont.preferredFont(forTextStyle: .title2)
        case .title3:
            uiFont = UIFont.preferredFont(forTextStyle: .title3)
        case .headline:
            uiFont = UIFont.preferredFont(forTextStyle: .headline)
        case .subheadline:
            uiFont = UIFont.preferredFont(forTextStyle: .subheadline)
        case .callout:
            uiFont = UIFont.preferredFont(forTextStyle: .callout)
        case .caption:
            uiFont = UIFont.preferredFont(forTextStyle: .caption1)
        case .caption2:
            uiFont = UIFont.preferredFont(forTextStyle: .caption2)
        case .footnote:
            uiFont = UIFont.preferredFont(forTextStyle: .footnote)
        case .body:
            fallthrough
        default:
            uiFont = UIFont.preferredFont(forTextStyle: .body)
        }
        
        return uiFont
    }
}
protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    func present(from sourceView: UIView, with source: UIImagePickerController.SourceType, onPresent: Action?) {

        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            return
        }

        self.pickerController.sourceType = source
        self.presentationController?.present(self.pickerController, animated: true, completion: onPresent)

//        if UIDevice.current.userInterfaceIdiom == .pad {
//            alertController.popoverPresentationController?.sourceView = sourceView
//            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
//            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
//        }

    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {

}

