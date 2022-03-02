import UIKit

public extension UIImageView {
    @discardableResult
    func image(_ image: UIImage?) ->  Self {
        self.image = image
        return self
    }

    @discardableResult
    func contentMode(_ contentmode: ContentMode) ->  Self {
        self.contentMode = contentmode
        return self
    }

    @discardableResult
    func clipsToBounds(_ value: Bool) ->  Self {
        self.clipsToBounds = value
        return self
    }
}
