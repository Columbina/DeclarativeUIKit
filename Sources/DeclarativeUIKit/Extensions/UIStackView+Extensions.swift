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

    @discardableResult
    func addArranged(@DeclarativeViewBuilder viewBuilder: () -> [UIView]) -> Self {
        viewBuilder().forEach { addArrangedSubview($0) }
        return self
    }

    // Inspired by: https://developer.apple.com/documentation/swiftui/foreach
    @discardableResult
    func forEach<Data>(_ collection: Data, _ content: (Data.Element) -> UIView) -> Self where Data: RandomAccessCollection {
        collection.forEach {
            let content = content($0)
            if content as? Spacer != nil {
                spacer()
            } else {
                addArrangedSubview(content)
            }
        }
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
        let spacer = Spacer()
        addArranged(spacer)
        applyEqualHeightsIfManySpacers(spacer)
        return self
    }

    @discardableResult
    func spacer(height: CGFloat) -> Self {
        addArranged(FixedSpacer(height: height))
        return self
    }

    @discardableResult
    func spacer(width: CGFloat) -> Self {
        addArranged(FixedSpacer(width: width))
        return self
    }

    private func applyEqualHeightsIfManySpacers(_ spacer: Spacer) {
        guard arrangedSubviews.count > 1 else { return }

        let existingSpacer = arrangedSubviews.first { $0.self is Spacer }
        existingSpacer?
            .connect(\.heightAnchor, to: spacer.heightAnchor)
            .connect(\.widthAnchor, to: spacer.widthAnchor)
    }
}


private extension Array where Element: UIView {
    func firstSpacer(where condition: @escaping(Spacer) -> Bool) -> Spacer? {
        first {
            guard let spacer = $0.self as? Spacer else {
                return false
            }

            return condition(spacer)
        } as? Spacer
    }
}

