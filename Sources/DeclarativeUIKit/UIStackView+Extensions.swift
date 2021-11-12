import UIKit

public extension UIStackView {
    @discardableResult
    func spacing(_ value: CGFloat) -> Self {
        spacing = value
        return self
    }

    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    @discardableResult
    func addArranged(_ view: UIView) -> Self {
        addArrangedSubview(view)
        return self
    }

    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func enableUserInteraction(_ isEnabled: Bool) -> Self {
        isUserInteractionEnabled = isEnabled
        return self
    }

    /// Spacer mimics the same behavior as Spacer in SwiftUI.
    /// For more information, see [SwiftUI Spacer](https://developer.apple.com/documentation/swiftui/spacer)
    ///
    /// Usage example:
    ///
    /// If you want to "push" a view to the right edge of the screen:
    /// ```
    ///     HorizontalStack()
    ///         .spacer()
    ///         .addArranged(
    ///             UIView()
    ///         )
    /// ```
    /// If you want to **centralize** a view:
    /// ```
    ///     HorizontalStack() // or vertical
    ///         .spacer()
    ///         .addArranged(
    ///             UIView()
    ///         )
    ///         .spacer()
    /// ```
    ///
    @discardableResult
    func spacer() -> Self {
        setupNewSpacer(Spacer())
        return self
    }

    @discardableResult
    func spacer(height: CGFloat) -> Self {
        addArranged(
            FixedSpacer(height: height)
        )
        return self
    }

    @discardableResult
    func spacer(width: CGFloat) -> Self {
        addArranged(
            FixedSpacer(width: width)
        )
        return self
    }

    private func setupNewSpacer(_ spacer: Spacer) {
        addArrangedSubview(spacer)
        applyEqualHeightsIfManySpacers(spacer)
    }
    
    private func applyEqualHeightsIfManySpacers(_ spacer: Spacer) {
        guard arrangedSubviews.count > 1 else { return }
        let existingSpacer = arrangedSubviews.first { $0.self is Spacer }
        existingSpacer?
            .connect(\.heightAnchor, to: spacer.heightAnchor)
            .connect(\.widthAnchor, to: spacer.widthAnchor)
    }
}
