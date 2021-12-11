import UIKit

public extension UIButton {
    @discardableResult
    func set(title: String, for state: UIControl.State) -> Self {
        self.setTitle(title, for: state)
        return self
    }
}
