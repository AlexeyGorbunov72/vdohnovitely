import SwiftUI

struct DreamScreen: View {

    @State var model: [DreamCardModel]

    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
                .frame(height: 30)

            ForEach(model) { card in
                DreamsCardView(model: card)
            }

            Spacer()
                .frame(height: 50)
            
            Text("Мечт мало не бывает 🥰🥰🥰")
                .font(Font.system(size: 20))
                .foregroundColor(Color(.white.withAlphaComponent(0.5)))

            Spacer()
                .frame(height: 150)
        }
        .padding([.bottom], -50)
    }
}

struct DreamScreen_Previews: PreviewProvider {
    static var previews: some View {
        DreamScreen(model: [.stub, .stub2, .stub3])
    }
}
