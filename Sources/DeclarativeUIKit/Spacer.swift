import UIKit

/// Spacer is inspired by the equivalent component in SwiftUI
public final class Spacer: UIView {
    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
      super.init(frame: .zero)

      if let width = width {
        set(\.widthAnchor, to: width)
      }

      if let height = height {
        set(\.heightAnchor, to: height)
      }
    }

    required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
