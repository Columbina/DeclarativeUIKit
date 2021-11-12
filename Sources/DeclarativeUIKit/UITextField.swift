import UIKit

public extension UITextField {
    @discardableResult
    func placeholder(_ text: String) -> Self {
        self.placeholder = text
        return self
    }
}
