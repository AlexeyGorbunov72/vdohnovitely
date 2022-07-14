import SwiftUI

struct TabBarView: View {
  @ObservedObject var tabBarZalupa = TabBar.shared

  var body: some View {
    RoundedRectangle(cornerRadius: 20)
    .overlay {
      ZStack {
        HStack(alignment: .center) {
          Spacer(minLength: 10)
          Image(
            uiImage: tabBarZalupa.curiosityVisible
              ? VdohnovitelyAsset.curiosityIcon.image
              : VdohnovitelyAsset.curiosityIconInvis.image
          )
            .onTapGesture {
              tabBarZalupa.taped(.tapCuriosity)
              tabBarZalupa.publisher.send(.curiosity)
            }
          Spacer(minLength: 10)
          Image(
            uiImage: tabBarZalupa.goalVisible
              ? VdohnovitelyAsset.goalIcon.image
              : VdohnovitelyAsset.goalIconInvis.image
          )
            .onTapGesture {
              tabBarZalupa.taped(.tapGoal)
              tabBarZalupa.publisher.send(.goal)
            }
          Spacer(minLength: 10)
          Image(
            uiImage: tabBarZalupa.dreamVisible
              ? VdohnovitelyAsset.dreamIcon.image
              : VdohnovitelyAsset.dreamIconInvis.image
          )
            .onTapGesture {
              tabBarZalupa.taped(.tapDream)
              tabBarZalupa.publisher.send(.dream)
            }
          Spacer(minLength: 10)
        }
      }
    }
    .foregroundColor(Color(VdohnovitelyAsset.tabBarColor.color))
    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .bottom)
  }
}

struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}

