import SwiftUI

struct GoalsScreen: View {

    @State var model: [GoalsCardModel]

    var body: some View {
        ScrollView(showsIndicators: false) {

            Spacer()
                .frame(height: 30)

            ZStack {

                Color(VdohnovitelyAsset.cardBackgroundColor.color)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text("Минутка мотивации")
                        .foregroundColor(.orange)
                        .font(Font.headline.bold())
                        .padding([.top, .leading, .trailing], 10)

                    Text(
                        "Я верю в силу, когда что-то идет не так. Завтра новый день, и я верю в чудеса. Одри Хепберн"
                    )
                    .foregroundColor(.white)
                    .font(Font.body)
                    .padding(10)
                }
            }
            .frame(width: 360, height: 150)

            ForEach(model) { card in
                GoalsCardView(model: card)
                    .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
                    .scaledToFit()
            }

            Spacer()
                .frame(height: 50)

            Text("Не заводи много целей,может не хватить на все времени 🥰🥰🥰")
                .font(Font.system(size: 20))
                .foregroundColor(Color(.white.withAlphaComponent(0.5)))
                .padding([.trailing, .leading], 20)

            Spacer()
                .frame(height: 150)
        }
        .padding([.bottom], -50)
    }
}

struct GoalsScreen_Previews: PreviewProvider {
  static var previews: some View {
    GoalsScreen(model: [.stub2, .stub, .stub, .stub3])
  }
}
