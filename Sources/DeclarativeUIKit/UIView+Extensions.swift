import UIKit

public extension UIView {

    // MARK: - add

    @discardableResult
    func add(_ view: UIView) -> Self {
        add(view, padding: 0)
        return self
    }

    @discardableResult
    func add(_ view: UIView, padding: CGFloat) -> Self {
        let edgeInsets = DeclarativeEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        add(view, padding: edgeInsets)
        return self
    }

    @discardableResult
    func add(_ view: UIView, padding: DeclarativeEdgeInsets) -> Self {
        addSubview(view)
        view.expand(to: self, padding: padding)
        return self
    }

    // MARK: - expand

    @discardableResult
    func expand(to view: UIView) -> Self {
        expand(to: view, padding: 0)
        return self
    }

    @discardableResult
    func expand(to view: UIView, padding: CGFloat) -> Self {
        let edgeInsets = DeclarativeEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        expand(to: view, padding: edgeInsets)
        return self
    }

    @discardableResult
    func expand(to view: UIView, padding: DeclarativeEdgeInsets) -> Self {
        if #available(iOS 11.0, *) {
            connect(\.topAnchor, to: view.safeAreaLayoutGuide.topAnchor, padding: padding.top)
            connect(\.leadingAnchor, to: view.safeAreaLayoutGuide.leadingAnchor, padding: padding.leading)
            connect(\.trailingAnchor, to: view.safeAreaLayoutGuide.trailingAnchor, padding: -padding.trailing)
            connect(\.bottomAnchor, to: view.safeAreaLayoutGuide.bottomAnchor, padding: -padding.bottom)
        } else {
            connect(\.topAnchor, to: view.topAnchor, padding: padding.top)
            connect(\.leadingAnchor, to: view.leadingAnchor, padding: padding.leading)
            connect(\.trailingAnchor, to: view.trailingAnchor, padding: -padding.trailing)
            connect(\.bottomAnchor, to: view.bottomAnchor, padding: -padding.bottom)
        }

        return self
    }

    // MARK: - connect

    @discardableResult
    func connect(_ keyPath: KeyPath<UIView, NSLayoutYAxisAnchor>, to anchor: NSLayoutYAxisAnchor) -> Self {
        connect(keyPath, to: anchor, padding: 0)
    }

    @discardableResult
    func connect(_ keyPath: KeyPath<UIView, NSLayoutXAxisAnchor>, to anchor: NSLayoutXAxisAnchor) -> Self {
        connect(keyPath, to: anchor, padding: 0)
    }

    @discardableResult
    func connect(_ keyPath: KeyPath<UIView, NSLayoutYAxisAnchor>, to anchor: NSLayoutYAxisAnchor, padding: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self[keyPath: keyPath].constraint(equalTo: anchor, constant: padding).isActive = true
        return self
    }

    @discardableResult
    func connect(_ keyPath: KeyPath<UIView, NSLayoutXAxisAnchor>, to anchor: NSLayoutXAxisAnchor, padding: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self[keyPath: keyPath].constraint(equalTo: anchor, constant: padding).isActive = true
        return self
    }

    @discardableResult
    func connect(_ keyPath: KeyPath<UIView, NSLayoutDimension>, to anchor: KeyPath<UIView, NSLayoutDimension>) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self[keyPath: keyPath].constraint(equalTo: self[keyPath: anchor]).isActive = true
        return self
    }

    @discardableResult
    func connect(_ keyPath: KeyPath<UIView, NSLayoutDimension>, to anchor: NSLayoutDimension) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self[keyPath: keyPath].constraint(equalTo: anchor).isActive = true
        return self
    }

    // MARK: - set

    @discardableResult
    func set(_ keyPath: KeyPath<UIView, NSLayoutDimension>, to constant: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self[keyPath: keyPath].constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    func set(_ keyPath: KeyPath<UIView, NSLayoutDimension>, greaterThanOrEqualTo constant: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self[keyPath: keyPath].constraint(greaterThanOrEqualToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    func set(compressionResistance priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    @discardableResult
    func set(contentHuggingPriority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(contentHuggingPriority, for: axis)
        return self
    }

    // MARK: - backgroungColor

    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    // MARK: - corner radius

    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        clipsToBounds = true
        return self
    }

    @discardableResult
    func childPadding(_ value: CGFloat) -> Self {
        guard let child = subviews.first else { return self }
        child.removeFromSuperview()
        add(child, padding: value)
        return self
    }

    @discardableResult
    func childPadding(_ value: DeclarativeEdgeInsets) -> Self {
        guard let child = subviews.first else { return self }
        child.removeFromSuperview()
        add(child, padding: value)
        return self
    }

    @discardableResult
    func dropShadow(offset: CGSize = CGSize(width: 0, height: 1),
                    radius: CGFloat = 1,
                    opacity: Float = 0.5) -> Self {
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        return self
    }
}

public struct DeclarativeEdgeInsets {
    let top: CGFloat
    let leading: CGFloat
    let bottom: CGFloat
    let trailing: CGFloat

    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
}
