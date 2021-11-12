import UIKit

/// Fixed Spacer has a pre-defined height or width
public final class FixedSpacer: Spacer {
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
