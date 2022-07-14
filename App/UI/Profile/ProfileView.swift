//
//  Profile.swift
//  Vdohnovitely
//
//  Created by Danil Dubov on 14.07.2022.
//  Copyright © 2022 dddddjalsdjakdw. All rights reserved.
//

import SwiftUI

class Profile: ObservableObject {
  @Published var model: ProfileModel

  init(model: ProfileModel) { self.model = model }
}

struct ProfileView: View {

  @ObservedObject var model: Profile

  var body: some View {

    ScrollView {
      VStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 19)
          .padding([.trailing, .leading], 30)
          .overlay(alignment: .leading) {
            HStack {
              if let image = model.model.image {
                Image(uiImage: image)
                  .resizable()
                  .frame(width: 80, height: 80)
                  .scaledToFit()
                  .clipShape(Circle())
                  .padding(.leading, 40)
              } else {
                Circle()
                  .frame(width: 80, height: 80)
                  .foregroundColor(.gray)
                  .overlay(alignment: .center) {
                    Image(systemName: "camera")
                  }
                  .padding(.leading, 40)
              }

              VStack(alignment: .leading) {
                TextField("Имя", text: $model.model.name)
                  .foregroundColor(.white)
                  .frame(minWidth: 80, maxWidth: 200)
                Divider()
                  .background(.white)
                  .frame(width: 200)
                TextField("Фамилия", text: $model.model.familyName)
                  .foregroundColor(.white)
                  .frame(minWidth: 80, maxWidth: 200)
              }
            }
          }
          .frame(width: .infinity, height: 106, alignment: .center)
          .foregroundColor(Color(VdohnovitelyAsset.cardBackgroundColor.color))

        Text("Пожалуйста, добавьте имя и фотографию")
          .foregroundColor(Color(VdohnovitelyAsset.textFiledPlaceholderColor.color))
          .font(Font.system(size: 14))
          .padding(EdgeInsets(top: 3, leading: 50, bottom: 28, trailing: 0))

        Text("О СЕБЕ")
          .padding(EdgeInsets(top: 0, leading: 40, bottom: 3, trailing: 0))
          .font(Font.system(size: 15))
          .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))

        RoundedRectangle(cornerRadius: 19)
          .padding([.trailing, .leading], 30)
          .foregroundColor(Color(VdohnovitelyAsset.cardBackgroundColor.color))
          .frame(width: .infinity, height: 106, alignment: .center)
          .overlay {
            MultilineTextFieldProfile(
              "Расскажите о себе, своих целях и мечтах",
              text: $model.model.about
            )
              .padding([.leading, .trailing], 40)
          }

        Text("Достижения")
          .padding(EdgeInsets(top: 0, leading: 40, bottom: 3, trailing: 0))
          .font(Font.system(size: 24))
          .foregroundColor(Color(VdohnovitelyAsset.accentTextColor.color))

        ScrollView(.horizontal) {
          HStack {
            ForEach(model.model.achievements) { achievement in
              Image(uiImage: achievement.image)
                .opacity(achievement.completed ? 1 : 0.3)
            }
          }
          .padding([.trailing, .leading], 40)
        }

        Text("Статистика")
          .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
          .font(Font.system(size: 24))
          .foregroundColor(Color(VdohnovitelyAsset.accentTextColor.color))

        RoundedRectangle(cornerRadius: 19)
          .padding([.trailing, .leading], 30)
          .foregroundColor(Color(VdohnovitelyAsset.cardBackgroundColor.color))
          .frame(width: .infinity, height: 168, alignment: .center)
          .overlay(alignment: .leading) {
            HStack(alignment: .center) {
              GeometryReader { geometry in
                ChartsView(
                  model: model.model.dreamsCart,
                  x: geometry.frame(in: .local).midX,
                  y: geometry.frame(in: .local).midY,
                  color1: Color(VdohnovitelyAsset.chartsGreenColor.color),
                  color2: Color(VdohnovitelyAsset.chartsGreenLightColor.color)
                )
                  .padding(.leading, 10)
              }

              VStack(alignment: .leading) {
                HStack {
                  Circle()
                    .foregroundColor(Color(VdohnovitelyAsset.chartsGreenColor.color))
                    .frame(width: 14, height: 14)

                  Text("Мечты исполнились")
                    .font(Font.system(size: 15))
                    .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))
                }
                HStack() {
                  Circle()
                    .foregroundColor(Color(VdohnovitelyAsset.chartsGreenLightColor.color))
                    .frame(width: 14, height: 14)
                  Text("Я еще мечтаю")
                    .font(Font.system(size: 15))
                    .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))
                }
              }
              .padding(.trailing, 30)
            }
          }

        RoundedRectangle(cornerRadius: 19)
          .padding([.trailing, .leading], 30)
          .foregroundColor(Color(VdohnovitelyAsset.cardBackgroundColor.color))
          .frame(width: .infinity, height: 168, alignment: .center)
          .overlay(alignment: .leading) {
            HStack(alignment: .center) {
              GeometryReader { geometry in
                ChartsView(
                  model: model.model.goalsCart,
                  x: geometry.frame(in: .local).midX,
                  y: geometry.frame(in: .local).midY,
                  color1: Color(VdohnovitelyAsset.chartsPinkColor.color),
                  color2: Color(VdohnovitelyAsset.chartsPinkLightColor.color)
                )
                  .padding(.leading, 10)
              }

              VStack(alignment: .leading) {
                HStack {
                  Circle()
                    .foregroundColor(Color(VdohnovitelyAsset.chartsPinkColor.color))
                    .frame(width: 14, height: 14)

                  Text("Цели достигнуты")
                    .font(Font.system(size: 15))
                    .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))
                }
                HStack() {
                  Circle()
                    .foregroundColor(Color(VdohnovitelyAsset.chartsPinkLightColor.color))
                    .frame(width: 14, height: 14)
                  Text("Стремлюсь к целям")
                    .font(Font.system(size: 15))
                    .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))
                }
              }
              .padding(.trailing, 30)
            }
          }


      }
      .onTapGesture {
        UIApplication.shared.inputView?.endEditing(true)
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    }
  }
}


struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(VdohnovitelyAsset.backgroundColor.color)
      ProfileView(model: .init(model: .stub))
    }
  }
}

fileprivate struct UITextViewWrapperProfile: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapperProfile>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        textField.textContainer.maximumNumberOfLines = 4
        textField.textColor = .white

        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapperProfile>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        UITextViewWrapperProfile.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapperProfile.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }

}

struct MultilineTextFieldProfile: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    @State var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

    var body: some View {
        UITextViewWrapperProfile(text: self.internalText, calculatedHeight: $dynamicHeight, onDone: onCommit)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}
