import SwiftUI
import Alamofire

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
              if let createDate = model.createDate {
                Text(createDate)
                  .foregroundColor(Color(VdohnovitelyAsset.mutedTextColor.color))
                  .font(.system(size: 14))
              }
            }
            if let tasks = model.tasks {
              GoalsProgressBarView(
                screentWidth: geometry.size.width,
                model: model.progressBarModel
              )
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
              ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                  ForEach(tasks) { task in
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
                      if let deadLineDate = task.deadLineDate {
                        Text(deadLineDate)
                          .foregroundColor(task.taskTimeStatus.sectionColor)
                      }
                    }
                    .onTapGesture {
                      goalsManager.publisher.send(.tapOnTask(task.id))
                    }
                  }
                }
                .padding()
              }
            } else {
              GoalsProgressBarView(
                screentWidth: geometry.size.width,
                model: GoalsProgressBarModel(timeStatuses: [.normal, .normal, .normal])
              )
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))

              Text("Добавьте пункт - сделайте первый шаг к своей цели!")
                .foregroundColor(Color(VdohnovitelyAsset.mainTextWhiteColor.color))
                .font(Font.system(size: 16))
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
    VStack {
      GoalsCardView(model: .stub2)
        .scaledToFit()
      GoalsCardView(model: .stub3)
        .scaledToFit()
    }

  }
}
