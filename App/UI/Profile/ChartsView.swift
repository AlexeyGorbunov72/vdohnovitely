import SwiftUI

struct ChartsView: View {

  @State var model: ChartsStatModel
  var x: Double
  var y: Double
  var color1: Color
  var color2: Color

  var body: some View {
    ZStack {
      ArcView(
        angle: getAngle(model.count, completed: model.completedCount),
        x: x,
        y: y,
        color1: color1,
        color2: color2
      )
    }
    .frame(width: 130, height: 130)
    .scaledToFit()
  }

  func getAngle(_ count: Int, completed: Int) -> Double {
    return Double((360 / count ) * completed)
  }
}

struct ChartsView_Previews: PreviewProvider {
  static var previews: some View {
    ChartsView(
      model: ChartsStatModel(completedCount: 2, count: 10),
      x: 100,
      y: 100,
      color1: Color(VdohnovitelyAsset.chartsPinkColor.color),
      color2: Color(VdohnovitelyAsset.chartsPinkLightColor.color)
    )
  }
}

struct ArcView: View {
  @State var angle: Double
  var x: Double
  var y: Double
  var color1: Color
  var color2: Color

  var body: some View {
    ZStack {
      Path { path in
        path.move(to: CGPoint(x: x, y: y))
        path.addArc(
          center: .init(x: x, y: y),
          radius: 65,
          startAngle: Angle(degrees: 0.0),
          endAngle: Angle(degrees: angle),
          clockwise: false
        )
      }
      .fill(color1)
      Path { path in
        path.move(to: CGPoint(x: x, y: y))
        path.addArc(
          center: .init(x: x, y: y),
          radius: 65,
          startAngle: Angle(degrees: angle),
          endAngle: Angle(degrees: 360),
          clockwise: false
        )
      }
      .fill(color2)
    }
  }
}
