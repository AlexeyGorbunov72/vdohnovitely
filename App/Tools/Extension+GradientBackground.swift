import Foundation
import UIKit

//bg gradient
//type: radial
//синий #13083D
//сиреневый #7D47BF
//розовый #FF929F
//желтый #FFD28F

extension UIViewController {
    func setGradientBackground() {
        let blue = UIColor(rgb: 0x13083D).cgColor
        let lilac = UIColor(rgb: 0x7D47BF).cgColor
        let pink = UIColor(rgb: 0xFF929F).cgColor
        let yellow = UIColor(rgb: 0xFFD28F).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [yellow, pink, lilac, blue]
        gradientLayer.locations = [0.0, 0.1, 0.3, 0.6, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
