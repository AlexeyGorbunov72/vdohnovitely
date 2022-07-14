import SwiftUI

struct EditorView: View {

    @State var blocks: [TextModel] = [
        .body,
        .subheader,
        .header,
        .name
    ]

    @State var anus: String = ""

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(blocks) { block in
//                    TextField("Залупа", text: $anus)
//                    TextFactory.makeText(from: block, with: $anus)
                    UltimateTextEditor(textModel: block)
                }
            }.frame(alignment: .topLeading)
        }.frame(alignment: .topLeading)
        
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
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

    public func makeUIView(context: Context) -> UIViewType {

        UIUltimateTextView()
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

}

final class UIUltimateTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    private func common() {
        font = .systemFont(ofSize: 26)
        textColor = .black
        allowsEditingTextAttributes = true
        UIMenuController.shared.menuItems = [
            .init(title: "Аа", action: #selector(changeFont(_:)))
        ]
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

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController = UIMenuController.shared
        if whiteList == Selector.initialWhiteList {
            if action.description == "_showTextStyleOptions:" {
                return true
            }
        }
        if var menuItems = menuController.menuItems,
            (menuItems.map { $0.action }).elementsEqual([.toggleBoldface, .toggleItalics, .toggleUnderline]) {
            // The font style menu is about to become visible
            // Add a new menu item for strikethrough style
            menuItems.append(UIMenuItem(title: "Strikethrough", action: .toggleStrikethrough))
            menuController.menuItems = menuItems
            return true
        }
        guard whiteList.contains(where: { $0 == action }) else {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }

    @objc
    func fuck() {
        print("Половой хуй")
    }

    @objc
    func toggleStrikethrough(_ sender: UITextView) {
        print("Половой хуй")
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
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func becameHeader(_ sender: UITextView) {
        font = .systemFont(ofSize: 25)
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func becameSubheader(_ sender: UITextView) {
        font = .systemFont(ofSize: 20)
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    @objc
    func becameBody(_ sender: UITextView) {
        font = .systemFont(ofSize: 15)
        UIMenuController.shared.update()
        whiteList = Selector.initialWhiteList
    }

    var whiteList: [Selector] = Selector.initialWhiteList
}


private extension Selector {
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
    static let fuck = #selector(UIUltimateTextView.fuck)
    static let select = #selector(UIUltimateTextView.select(_:))
    static let changeFont = #selector(UIUltimateTextView.changeFont(_:))
    static let becameName = #selector(UIUltimateTextView.becameName(_:))
    static let becameHeader = #selector(UIUltimateTextView.becameHeader(_:))
    static let becameSubheader = #selector(UIUltimateTextView.becameSubheader(_:))
    static let becameBody = #selector(UIUltimateTextView.becameBody(_:))
}
