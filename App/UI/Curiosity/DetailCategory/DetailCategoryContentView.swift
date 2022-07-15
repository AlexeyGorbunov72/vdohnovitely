import Foundation
import SwiftUI

struct DetailCategoryContentView: View {

    let category: CaregoryModel

    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 30)
            DetailCategoryView(category: category)
            Spacer()
                .frame(height: 100)
        }
    }
}
