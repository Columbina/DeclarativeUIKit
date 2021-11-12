import UIKit

public extension UIImageView {
    @discardableResult
    func image(_ image: UIImage?) ->  UIImageView {
        self.image = image
        return self
    }

    @discardableResult
    func contentMode(_ contentmode: ContentMode) ->  UIImageView {
        self.contentMode = contentmode
        return self
    }
}
