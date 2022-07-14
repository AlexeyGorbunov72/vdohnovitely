import SwiftUI

struct GoalsScreen: View {

  @State var model: [GoalsCardModel]

  var body: some View {
    ScrollView {
      ForEach(model) { card in
        GoalsCardView(model: card)
          .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
          .scaledToFit()
      }
    }
  }
}

struct GoalsScreen_Previews: PreviewProvider {
  static var previews: some View {
    GoalsScreen(model: [.stub2, .stub, .stub])
  }
}
