import SwiftUI

struct GoalsProgressBarView: View {
    let screentWidth: CGFloat

    @State var model: GoalsProgressBarModel

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(model.timeStatuses) { timeStatus in
                RoundedRectangle(cornerRadius: 4)
                    .frame(
                        minWidth: progressSectionWidth(
                            sectionCount: model.timeStatuses.count,
                            screenWidth: screentWidth
                          ),
                        maxHeight: 5,
                        alignment: .center
                    )
                    .foregroundColor(timeStatus.sectionColor)
            }
        }
    }
}

private func progressSectionWidth(
  sectionCount: Int,
  screenWidth: CGFloat
) -> CGFloat {
  return (screenWidth / CGFloat(sectionCount)) - CGFloat((sectionCount - 1) * 4) - 8
}

struct GoalsProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsProgressBarView(
            screentWidth: UIScreen.main.bounds.size.width,
            model: .stub
        )
    }
}
