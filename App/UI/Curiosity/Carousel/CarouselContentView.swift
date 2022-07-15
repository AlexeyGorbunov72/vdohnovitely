import Foundation
import SwiftUI

struct CarouselContentView: View {

    weak var delegate: CarouselViewProtocol?
    @State var model: [CaregoryModel]

    var body: some View {
        ScrollView {
            CarouselView(delegate: delegate, model: model)
        }
    }
}
