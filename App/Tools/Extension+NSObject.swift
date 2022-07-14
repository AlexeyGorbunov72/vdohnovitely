import Foundation
import Combine

extension NSObject {

    private static var key: UInt8 = 0 {
        didSet {
            print(key)
        }
    }

    private class CancellableWrapper {
        let cancellables: Set<AnyCancellable>
        
        init(cancellables: Set<AnyCancellable>) {
            self.cancellables = cancellables
        }
    }

    var disposable: Set<AnyCancellable> {
        get {
            if let wrapper = objc_getAssociatedObject(self, &Self.key) as? CancellableWrapper {
                return wrapper.cancellables
            }
            let cancellables = Set<AnyCancellable>()
            self.disposable = cancellables
            return cancellables
        }
        set {
            let wrapper = CancellableWrapper(cancellables: newValue)
            objc_setAssociatedObject(self, &Self.key, wrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
