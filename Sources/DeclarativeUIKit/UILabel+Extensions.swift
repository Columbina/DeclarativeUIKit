import UIKit

public extension UILabel {
    @discardableResult
    func text(_ text: String?) -> UILabel {
        self.text = text
        return self
    }

    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> UILabel {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func textColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }

    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }

    @discardableResult
    func set(textAlignment alignment: NSTextAlignment) -> UILabel {
        self.textAlignment = alignment
        return self
    }
}
