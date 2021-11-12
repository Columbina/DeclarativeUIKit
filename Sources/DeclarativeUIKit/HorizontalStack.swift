import UIKit

public class HorizontalStack: UIStackView {
    public init() {
        super.init(frame: CGRect.zero)
        axis(.horizontal)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
