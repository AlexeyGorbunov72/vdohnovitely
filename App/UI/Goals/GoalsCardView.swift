import SwiftUI

struct GoalsCardView: View {

  @State var model: GoalsCardModel
  let goalsManager = GoalsManager.shared

  var body: some View {
    RoundedRectangle(cornerRadius: 19)
      .onTapGesture {
        goalsManager.publisher.send(.tapOnCard(model.id))
      }
      .overlay() {
        GeometryReader { geometry in
          VStack(alignment: .center, spacing: 12) {
            HStack {
              Text(model.name)
                .foregroundColor(Color(VdohnovitelyAsset.accentTextColor.color))
                .font(.system(size: 24))
              Spacer(minLength: 10)
              Text(model.createDate)
                .foregroundColor(Color(VdohnovitelyAsset.mutedTextColor.color))
                .font(.system(size: 14))
            }
            GoalsProgressBarView(
              screentWidth: geometry.size.width,
              model: model.progressBarModel
            )
              .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
            ScrollView {
              VStack(alignment: .leading, spacing: 8) {
                ForEach(model.tasks) { task in
                  HStack {
                    ZStack {
                      Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                      if task.isCompleted {
                        Circle()
                          .frame(width: 10, height: 10)
                          .foregroundColor(.white)
                      }
                    }
                    Spacer(minLength: 18)
                    Text(task.name)
                      .foregroundColor(
                        task.isCompleted
                          ? Color(VdohnovitelyAsset.mutedTextColor.color)
                          : Color(VdohnovitelyAsset.mainTextWhiteColor.color)
                      )
                      .strikethrough(task.isCompleted)
                      .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 10)
                    Text(task.deadLineDate)
                      .foregroundColor(task.taskTimeStatus.sectionColor)
                  }
                  .onTapGesture {
                    goalsManager.publisher.send(.tapOnTask(task.id))
                  }
                }
              }
              .padding()
            }
          }
          .padding(EdgeInsets(top: 16, leading: 18, bottom: 16, trailing: 18))
        }
      }
      .foregroundColor(Color(VdohnovitelyAsset.cardBackgroundColor.color))
  }
}

struct GoalsCardView_Previews: PreviewProvider {
  static var previews: some View {
    GoalsCardView(model: .stub)
  }
}
