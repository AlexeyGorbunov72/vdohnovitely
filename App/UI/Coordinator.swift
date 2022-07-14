import Foundation
import Combine
import class UIKit.UIViewController

class Coordinator<Success, Failture: Error>: NSObject {
    let didFinishEvent = PassthroughSubject<Success, Failture>()
    let showScreenEvent = PassthroughSubject<UIViewController, Never>()

    var container: UIViewController? { nil }

    func start() { }    
}
