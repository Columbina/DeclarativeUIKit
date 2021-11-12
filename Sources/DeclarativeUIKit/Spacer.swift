import UIKit

/// Spacer mimics the same behavior as Spacer in SwiftUI.
/// For more information, see [SwiftUI Spacer](https://developer.apple.com/documentation/swiftui/spacer)
///
/// Usage example:
///
/// If you want to "push" a view to the right edge of the screen:
/// ```
///     HorizontalStack()
///         .addArranged(
///             Spacer()
///         )
///         .addArranged(
///             UIView()
///         )
/// ```
/// If you want to **centralize** a view:
/// ```
///     HorizontalStack() // or vertical
///         .addArranged(
///             Spacer()
///         )
///         .addArranged(
///             UIView()
///         )
///         .addArranged(
///             Spacer()
///         )
/// ```
///
public final class Spacer: UIView {
    private let width: CGFloat?
    private let height: CGFloat?

    var hasFixedSize: Bool {
        width != nil || height != nil
    }

    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height

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
