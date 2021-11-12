import UIKit

public class VerticalStack: UIStackView {
    public init() {
        super.init(frame: CGRect.zero)
        axis(.vertical)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
