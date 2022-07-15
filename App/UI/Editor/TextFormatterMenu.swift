import SwiftUI

struct Govno: Identifiable {
    let id: Int
    let isSelected: Bool
    let text: String
    let font: Font
}

struct Ochko: Identifiable {
    let id: Int
    let isSelected: Bool
    let systemName: String
}

struct Config {
    let fontSize: Font
    let style: [Style]
}

enum Style {
    case bold
    case italic
    case underline
    case strikethrough
}

struct TextFormatterMenu: View {
    @State var ochko: [Ochko] = [
        .init(id: 0, isSelected: false, systemName: "bold"),
        .init(id: 1, isSelected: false, systemName: "italic"),
        .init(id: 2, isSelected: false, systemName: "underline"),
        .init(id: 3, isSelected: false, systemName: "strikethrough")
    ]

    @State var anus: [Govno] = [
        .init(id: 0, isSelected: true, text: "Название", font: .largeTitle),
        .init(id: 1, isSelected: false, text: "Заголовок", font: .title),
        .init(id: 2, isSelected: false, text: "Подзаголовок", font: .title2),
        .init(id: 3, isSelected: false, text: "Основной текст", font: .footnote)
    ]

    var onClose: Action?
    var onSelectFontSize: ((Font) -> Void)?
    var onTextStyleSelect: ((Style) -> Void)?

    var body: some View {
        header
        fontSection
        styleSection
    }

    var header: some View {
        HStack {
            Text("Фомат")
                .font(.title)
            Spacer(minLength: 10)
            Image(systemName: "xmark.circle.fill")
                .onTapGesture {
                    onClose?()
                }
        }
        .padding()
    }

    var fontSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 10) {
                ForEach($anus) { $model in
                    Text(model.text)
                        .padding()
                        .background(model.isSelected ? .blue : .clear)
                        .font(model.font)
                        .cornerRadius(10)
                        .lineLimit(1)
                        .onTapGesture {
                            onSelectFontSize?(model.font)
                            withAnimation {
                                anus = anus.map { a in
                                    return Govno(
                                        id: a.id,
                                        isSelected: model.id == a.id ? true : false,
                                        text: a.text,
                                        font: a.font
                                    )
                                }
                            }
                        }
                }
            }.padding()
        }
    }

    var styleSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 2) {
                ForEach($ochko) { $model in
                    Spacer()
                    Image(systemName: model.systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50, alignment: .center)
                        .padding()
                        .background(model.isSelected ? .blue : .gray)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation {
                                if model.systemName == "bold" {
                                    onTextStyleSelect?(.bold)
                                }
                                if model.systemName == "italic" {
                                    onTextStyleSelect?(.italic)
                                }
                                if model.systemName == "underline" {
                                    onTextStyleSelect?(.underline)
                                }
                                if model.systemName == "strikethrough" {
                                    onTextStyleSelect?(.strikethrough)
                                }

                                ochko = ochko.map { a in
                                    return Ochko(
                                        id: a.id,
                                        isSelected: a.id == model.id ? !a.isSelected : a.isSelected,
                                        systemName: a.systemName

                                    )
                                }
                            }
                        }
                }
            }.padding()
        }
    }
}

//struct TextFormatterStyle: View {
//    let isSelected: Bool
//
//    let text: String
//    let width: CGFloat
//
//    var body: some View {
//
//    }
//}

struct TextFormatterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TextFormatterMenu()
    }
}
