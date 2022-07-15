import Foundation
import SwiftUI

struct CarouselContentView: View {

    weak var delegate: CarouselViewProtocol?

    var body: some View {
        ScrollView {
            CarouselView(delegate: delegate)
        }
    }
}
