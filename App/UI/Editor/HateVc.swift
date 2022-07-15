//
//  HateVc.swift
//  Vdohnovitely
//
//  Created by Aleksei Gorbunov on 15.07.2022.
//  Copyright © 2022 dddddjalsdjakdw. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class PassThrouView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            return nil
        }
        return view
    }
}

class HateVc: UIViewController {
    var textFormattingView: UIHostingController<TextFormatterMenu>?

    @Published var styles = Set<Style>()
    @Published var selectedFont: Font = .largeTitle

    var onFinish: Action?

    override func loadView() {
        super.loadView()
        view = PassThrouView()
    }
    override func viewDidLoad() {
        let textFormattingView = UIHostingController(
            rootView: TextFormatterMenu(
                onClose: close,
                onSelectFontSize: selectFont,
                onTextStyleSelect: onStyleSelect
            )
        )
        self.textFormattingView = textFormattingView

        add(textFormattingView)
        view.backgroundColor = .clear
        textFormattingView.view.snp.makeConstraints {
//            $0.trailing.leading.equalToSuperview()
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(450)
            $0.edges.equalToSuperview()
        }
    }

    public func presentationControllerDidDismiss(
      _ presentationController: UIPresentationController)
    {
      close()
    }
    func close() {
        dismiss(animated: true, completion: onFinish)
    }

    func selectFont(_ font: Font) {
        selectedFont = font
    }

    func onStyleSelect(_ style: Style) {
        if styles.contains(style) {
            styles.remove(style)
        } else {
            styles.insert(style)
        }
    }
}
