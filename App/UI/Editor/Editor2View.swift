//
//  Editor2View.swift
//  Vdohnovitely
//
//  Created by Aleksei Gorbunov on 14.07.2022.
//  Copyright © 2022 dddddjalsdjakdw. All rights reserved.
//

import SwiftUI
import UIKit

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: TextBlock
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?
    var onURLFinds: (([URL]) -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UIUltimateTextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear

        textField.returnKeyType = .continue
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        if text.isResponder {
            textField.becomeFirstResponder()
        }
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.attributedText != self.text.text {
            uiView.attributedText = self.text.text
        }
        let fuck = NSMutableAttributedString(attributedString: uiView.attributedText)
        fuck.addAttribute(NSAttributedString.Key.font, value: text.font, range: NSRange(location: 0, length: fuck.length))

        uiView.attributedText = fuck
        if text.isResponder {
            uiView.becomeFirstResponder()
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
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
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone, onURLFinds: onURLFinds)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<TextBlock>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        var onURLFinds: (([URL]) -> Void)?

        init(text: Binding<TextBlock>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil, onURLFinds: (([URL]) -> Void)?) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
            self.onURLFinds = onURLFinds
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = TextBlock(text: uiView.attributedText, font: text.wrappedValue.font)
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
            if text.wrappedValue.text.length < 1 {
                onDone?()
            }
            let urls = urlExists(uiView.attributedText.string)
            if urls.count > 0{
                print(urls)
                onURLFinds?(urls)
            }
        }

        func urlExists(_ input: String) -> [URL] {
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
            var urls = [URL]()

            for match in matches {
                guard let range = Range(match.range, in: input) else { continue }
                let url = input[range]
                print(url)
                if let urll = URL(string: String(url)) {
                    urls.append(urll)
                }
            }
            return urls
        }
    }

}

struct MultilineTextField: View {

    private var onCommit: (() -> Void)?
    var onURLFinds: (([URL]) -> Void)?

    @Binding private var text: TextBlock
    private var internalText: Binding<TextBlock> {
        Binding<TextBlock>(get: { self.text } ) {
            self.text = $0
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

    init(text: Binding<TextBlock>, onCommit: (() -> Void)? = nil, onURLFinds: (([URL]) -> Void)?) {
        self.onCommit = onCommit
        self._text = text
        self.onURLFinds = onURLFinds
    }

    var body: some View {
        UITextViewWrapper(text: $text, calculatedHeight: $dynamicHeight, onDone: onCommit, onURLFinds: onURLFinds)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
    }
}
