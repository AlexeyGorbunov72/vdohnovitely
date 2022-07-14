//
//  DreamsCardView.swift
//  Vdohnovitely
//
//  Created by Danil Dubov on 14.07.2022.
//  Copyright © 2022 dddddjalsdjakdw. All rights reserved.
//

import SwiftUI

struct DreamsCardView: View {

  let dreamsManager = DreamsManager.shared
  @State var model: DreamCardModel

  var body: some View {
    Image(uiImage: model.image ?? VdohnovitelyAsset.defultDreamImage.image)
      .resizable()
      .scaledToFit()
      .cornerRadius(19)
      .frame(height: 244)
      .overlay(alignment: .bottomLeading) {
        HStack {
          Text(model.name)
            .fontWeight(.bold)
            .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 20, trailing: 0))
            .font(.system(size: 20))
            .lineLimit(2)
        }
      }
      .onTapGesture {
          dreamsManager.publisher.send(.tapOnCard(model.id))
      }
  }
}

struct DreamsCardView_Previews: PreviewProvider {
  static var previews: some View {
    DreamsCardView(model: .stub)
  }
}
