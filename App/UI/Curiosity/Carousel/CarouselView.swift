import Foundation
import SwiftUI

protocol CarouselViewProtocol: AnyObject {

    func showDetailView(category: CaregoryModel)
}

struct CarouselView: View {

    weak var delegate: CarouselViewProtocol?
    @State var model: [CaregoryModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                Spacer()
                    .frame(width: 50)

                ForEach(model) { category in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        VStack(spacing: 8) {
                            ZStack {
                                Image(category.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200)
                                    .clipped()
                                    .cornerRadius(8)

                                Color(.black.withAlphaComponent(0.5))
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(category.title)
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding([.leading], 17)
                                    .padding([.top], 25)

                                    HStack {
                                        Text(category.text)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding([.leading], 20)
                                    .padding([.top], 3)

                                    Spacer()
                                }
                            }
                        }
                        .scaleEffect(.init(width: scale, height: scale))
                        .animation(.easeOut(duration: 1))
                        .padding(.vertical)
                        .onTapGesture {
                            delegate?.showDetailView(category: category)
                        }
                    }
                    .frame(width: 175, height: 400)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)
                }

                Spacer()
                    .frame(width: 50)
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

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
