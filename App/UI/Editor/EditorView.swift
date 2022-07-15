import SwiftUI
import LinkPresentation

typealias Action = () -> Void

struct EditorView: View {

    @ObservedObject var blocks: Blocks

    let onTextFormattingTapped: Action?
    let onListTapped: Action?
    let onCapturePhoto: Action?
    let onSelectPhoto: Action?
    let onBackgroundTapped: Action?
    let onSelectBlock: ((UUID) -> Void)?
    let onEmptyDelete: ((UUID) -> Void)?
    let onURLSFind: ((UUID, [URL]) -> Void)?
    let onFinish: Action?

    var ochko: some View {
        
        ZStack(alignment: .bottom) {
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Image(systemName: "xmark.circle")
                            .frame(alignment: .topTrailing)
                            .onTapGesture {
                                onFinish?()
                            }

                        ForEach($blocks.blocks) { $block in
                            makeBlock(from: $block)
                                .onTapGesture {
                                    onSelectBlock?(block.id)
                                }
                        }

                        Rectangle()
                            .foregroundColor(Color(Color.RGBColorSpace.sRGB, red: 0.0001, green: 0.0001, blue: 0.0001, opacity: 0.0001))
                            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height, alignment: .center)
                            .onTapGesture {
                                onBackgroundTapped?()
                            }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
            .padding()

            Color(.purple)
                .contentShape(Rectangle())
                .frame(minHeight: 40, maxHeight: 40, alignment: .bottom)
                .overlay(alignment: .center) {
                    HStack(alignment: .center, spacing: 10) {
                        Spacer(minLength: 10)
                        Image(uiImage: UIImage(systemName: "textformat")!)
                            .frame(width: 35, height: 35, alignment: .center)
                            .onTapGesture {
                                onTextFormattingTapped?()
                            }
                        Spacer(minLength: 10)
                        Image(uiImage: UIImage(systemName: "checklist")!)
                            .frame(width: 35, height: 35, alignment: .center)
                            .onTapGesture {
                                onListTapped?()
                            }
                        Spacer(minLength: 10)
                        
                        Menu {
                            Button(action: onSelectPhoto ?? {}) {
                                  Label("Выбрать фото", systemImage: "photo.on.rectangle")
                              }
                            Button(action: onCapturePhoto ?? {}) {
                                  Label("Снять фото", systemImage: "camera")
                              }
                          } label: {
                              Image(systemName: "camera")
                                  .foregroundColor(.black)
                          }
                        Spacer(minLength: 10)
                    }
                    .frame(minHeight: 40, maxHeight: 40, alignment: .bottom)
                    .foregroundColor(.purple)
                    .padding(.bottom, 7.5)
                }

        }
    }

    var body: some View {
        ochko
    }

    private func makeBlock(from block: Binding<Block>) -> some View {
        switch block.typeBlock.wrappedValue {
        case .checklist:
            return AnyView(ChecklistView(block: block.checklistBlock))

        case .image:
            return AnyView(
                Image(uiImage: block.imageBlock.wrappedValue!.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: UIScreen.main.bounds.width - 20, alignment: .center)
            )

        case .text:
            let textField = MultilineTextField(
                text: block.textBlock,
                onCommit: { onEmptyDelete?(block.id) },
                onURLFinds: { onURLSFind?(block.id, $0) }
            )
            return AnyView(textField)

        case .link:
            return AnyView(LinkViewRepresentable(metadata: block.linksBlock.wrappedValue!.metadata))
        }
    }
}



struct ChecklistView: View {

    @Binding var block: ChecklistBlock

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach($block.points) { $model in
                HStack(alignment: .center, spacing: 3) {
                    Image(systemName: model.isDone ? "circle.circle.fill" : "circle")
                    MultilineTextField(text: $model.text, onCommit: nil, onURLFinds: nil)
                }
            }
        }
    }
}

enum EditorBlock {

    case text(TextModel)
    case image
    case checkList
}

enum TextFactory {

    static func makeText(
        from model: TextModel,
        with binding: Binding<String>
    ) -> some View {
        switch model.size {
        case .name:
            return TextEditor(text: binding)
                .font(.largeTitle.weight(.bold))

        case .header:
            return TextEditor(text: binding).font(.headline)

        case .subheader:
            return TextEditor(text: binding).font(.subheadline)

        case .body:
            return TextEditor(text: binding).font(.body)
        }

//        model.transformations.forEach { transformation in
//            switch transformation {
//            case .underline:
//                text = text.underline()
//
//            case .strikethrough:
//                text = text.strikethrough()
//
//            case .bold:
//                text = text.bold()
//
//            case .italic:
//                text = text.italic()
//            }
//        }

//        return text
    }
}

typealias Attributes = AttributeScopes.UIKitAttributes

struct TextModel: Identifiable {
    let id: Int
    static let `header` = TextModel(
        id: 1,
        size: .header,
        transformations: [.underline],
        text: "Заголовок"
    )

    static let `name` = TextModel(
        id: 2,
        size: .name,
        transformations: [],
        text: "Название"
    )

    static let `subheader` = TextModel(
        id: 3,
        size: .subheader,
        transformations: [],
        text: "Подзаголовок"
    )

    static let body = TextModel(
        id: 4,
        size: .body,
        transformations: [],
        text: "Боди"
    )

    enum Style {

        enum Size {

            case name
            case header
            case subheader
            case body
        }

        enum Transformation {

            case bold
            case italic
            case underline
            case strikethrough
        }
    }

    let size: Style.Size
    let transformations: [Style.Transformation]
    let text: String

    var attributedString: AttributedString {
        let attributedString = AttributedString(text)
        var container = AttributeContainer()
 
        switch size {
        case .name:
            container[Attributes.FontAttribute.self] = .systemFont(ofSize: 30, weight: .bold)

        case .header:
            container[Attributes.FontAttribute.self] = .systemFont(ofSize: 25, weight: .bold)

        case .subheader:
            container[Attributes.FontAttribute.self] = .systemFont(ofSize: 20, weight: .bold)

        case .body:
            container[Attributes.FontAttribute.self] = .systemFont(ofSize: 17, weight: .regular)
        }


        return attributedString.settingAttributes(container)
    }
}

struct UltimateTextEditor: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<Self>
    typealias UIViewType = UIUltimateTextView

    let textModel: TextModel
    var onFinish: (() -> Void)?
    public func makeUIView(context: Context) -> UIViewType {
        UIUltimateTextView(textModel, onFinish: onFinish)
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {
        print(uiView)
        print(context)
    }
}

final class UIUltimateTextView: UITextView, UITextViewDelegate {

    private var onFinish: (() -> Void)?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    override public func deleteBackward() {
        if attributedText.length < 1 {
             onFinish?()
        }
        // do something for every backspace
        super.deleteBackward()
    }
    private func common() {
        font = .systemFont(ofSize: 26)
        textColor = .black
        allowsEditingTextAttributes = true
        backgroundColor = .purple
        delegate = self
        isScrollEnabled = false
//        UIMenuController.shared.menuItems = [
//            .init(title: "Аа", action: #selector(changeFont(_:)))
//        ]
    }

    init(_ model: TextModel, onFinish: (() -> Void)?) {
        super.init(frame: .zero, textContainer: nil)
        applyModel(model)
        self.onFinish = onFinish
        common()
    }

    func applyModel(_ model: TextModel) {
        switch model.size {
        case .name:
            font = .boldSystemFont(ofSize: 35)

        case .header:
            font = .systemFont(ofSize: 30)

        case .subheader:
            font = .systemFont(ofSize: 25)

        case .body:
            font = .systemFont(ofSize: 20)
        }
    }

    var hideMenu = false
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController = UIMenuController.shared
   
        if var menuItems = menuController.menuItems,
            (menuItems.map { $0.action }).elementsEqual([.toggleBoldface, .toggleItalics, .toggleUnderline]) {
            // The font style menu is about to become visible
            // Add a new menu item for strikethrough style
            menuItems.append(UIMenuItem(title: "Strikethrough", action: .toggleStrikethrough))
            menuController.menuItems = menuItems
            return true
        }
        return super.canPerformAction(action, withSender: sender)

        if action.description == "_showTextStyleOptions:" && !hideMenu {
            whiteList = [
                Selector.toggleBoldface,
                Selector.toggleUnderline,
                Selector.toggleItalics
            ]
            return true
        }

        guard whiteList.contains(where: { $0 == action }) else {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }

    @objc
    func changeFont(_ sender: UITextView) {
        UIMenuController.shared.menuItems = [
            .init(title: "Имя", action: #selector(becameName(_:))),
            .init(title: "Заголовок", action: #selector(becameHeader(_:))),
            .init(title: "Под Заголовок", action: #selector(becameSubheader(_:))),
            .init(title: "Основной", action: #selector(becameBody(_:))),
        ]
        UIMenuController.shared.update()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIMenuController.shared.showMenu(from: self, rect: self.bounds)
        }
        whiteList = Selector.titlesWhiteList
    }

    @objc
    func becameName(_ sender: UITextView) {
        font = .boldSystemFont(ofSize: 30)
        UIMenuController.shared.menuItems = [
            .init(title: "Аа", action: #selector(changeFont(_:)))
        ]
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func becameHeader(_ sender: UITextView) {
        font = .systemFont(ofSize: 25)
        UIMenuController.shared.menuItems = [
            .init(title: "Аа", action: #selector(changeFont(_:)))
        ]
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func becameSubheader(_ sender: UITextView) {
        font = .systemFont(ofSize: 20)
        UIMenuController.shared.menuItems = [
            .init(title: "Аа", action: #selector(changeFont(_:)))
        ]
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func becameBody(_ sender: UITextView) {
        font = .systemFont(ofSize: 15)
        UIMenuController.shared.menuItems = [
            .init(title: "Аа", action: #selector(changeFont(_:)))
        ]
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func toggleStrikethrough(_ sender: UITextView) {
        font = .systemFont(ofSize: 15)
        UIMenuController.shared.menuItems = [
            .init(title: "Аа", action: #selector(changeFont(_:)))
        ]
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }
    var whiteList: [Selector] = Selector.initialWhiteList

//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if let url = urlExists(attributedText.string) {
//            print(url)
//        }
//        return true
//    }
}


extension Selector {
    static let initialWhiteList: [Selector] = [
        .cut,
        .paste,
        .changeFont
    ]

    static let titlesWhiteList: [Selector] = [
        .becameBody,
        .becameHeader,
        .becameSubheader,
        .becameName
    ]

    static let textOptionsWhiteList: [Selector] = [
        .toggleItalics,
        .toggleBoldface,
        .toggleUnderline,
        .toggleStrikethrough
    ]

    static let toggleBoldface = #selector(UIUltimateTextView.toggleBoldface(_:))
    static let toggleItalics = #selector(UIUltimateTextView.toggleItalics(_:))
    static let toggleUnderline = #selector(UIUltimateTextView.toggleUnderline(_:))
    static let toggleStrikethrough = #selector(UIUltimateTextView.toggleStrikethrough(_:))
    static let cut = #selector(UIUltimateTextView.cut(_:))
    static let paste = #selector(UIUltimateTextView.paste(_:))
    static let select = #selector(UIUltimateTextView.select(_:))
    static let changeFont = #selector(UIUltimateTextView.changeFont(_:))
    static let becameName = #selector(UIUltimateTextView.becameName(_:))
    static let becameHeader = #selector(UIUltimateTextView.becameHeader(_:))
    static let becameSubheader = #selector(UIUltimateTextView.becameSubheader(_:))
    static let becameBody = #selector(UIUltimateTextView.becameBody(_:))
}

extension UIApplication {
    func endEditing() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

class CustomLinkView: LPLinkView {
    override var intrinsicContentSize: CGSize { CGSize(width: 0, height: super.intrinsicContentSize.height) }
}

struct LinkViewRepresentable: UIViewRepresentable {
 
    typealias UIViewType = CustomLinkView
    
    var metadata: LPLinkMetadata?
 
    func makeUIView(context: Context) -> CustomLinkView {
        guard let metadata = metadata else { return CustomLinkView() }
        let linkView = CustomLinkView(metadata: metadata)
        return linkView
    }
 
    func updateUIView(_ uiView: CustomLinkView, context: Context) {
    }
}
