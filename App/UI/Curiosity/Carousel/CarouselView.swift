import Foundation
import SwiftUI

struct CarouselView: View {

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(categories) { num in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        VStack(spacing: 8) {
                            ZStack {
                                Image(num.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200)
                                    .clipped()
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(num.title)
                                            .font(.system(size: 23, weight: .semibold))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding([.top, .leading], 17)

                                    HStack {
                                        Text(num.text)
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding([.leading], 20)

                                    Spacer()
                                }
                            }
                        }
                        .scaleEffect(.init(width: scale, height: scale))
                        .animation(.easeOut(duration: 1))
                        .padding(.vertical)
                        .onTapGesture {
                            print(num.id)
                        }
                    }
                    .frame(width: 175, height: 400)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                }
            }
            .frame(height: 600)
        }
    }

    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 175

        let viewFrame = proxy.frame(in: CoordinateSpace.global)

        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 175

        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }

        return scale
    }
}
