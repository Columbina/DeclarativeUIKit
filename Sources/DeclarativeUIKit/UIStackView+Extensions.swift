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
        if let view = view as? Spacer {
            addSpacer(view)
        } else {
            addArrangedSubview(view)
        }
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
    func spacer(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        addArranged(Spacer(width: width, height: height))
    }

    private func addSpacer(_ spacer: Spacer) {
        addArrangedSubview(spacer)
        if !spacer.hasFixedSize {
            applyEqualSizeIfManySpacers(spacer)
        }
    }

    // Find the first spacer which doesn't have a fixed size
    // and apply equal heights and width for the new spacer
    private func applyEqualSizeIfManySpacers(_ spacer: Spacer) {
        guard !spacer.hasFixedSize else { return }
        guard arrangedSubviews.count > 1 else { return }

        let nonFixedSizeSpacer = arrangedSubviews.firstSpacer { !$0.hasFixedSize }
        nonFixedSizeSpacer?
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
