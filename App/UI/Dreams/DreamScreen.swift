import SwiftUI

struct DreamScreen: View {

  @State var model: [DreamCardModel]

  var body: some View {
    ScrollView(showsIndicators: false) {
      ForEach(model) { card in
        DreamsCardView(model: card)
      }
    }
  }
}

struct DreamScreen_Previews: PreviewProvider {
  static var previews: some View {
    DreamScreen(model: [.stub, .stub2, .stub3, .stub3, .stub3, .stub3])
  }
}
