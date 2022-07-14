import Foundation
import UIKit

struct AppFont {
    enum FontType: String {
        case Articles = "Days One"
        case Text = "Jost"
    }

    static func font(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
