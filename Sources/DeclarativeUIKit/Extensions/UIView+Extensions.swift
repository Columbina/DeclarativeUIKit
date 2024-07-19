import UIKit

public extension UIView {

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    // MARK: - add

    @discardableResult
    func add(_ view: UIView,
             useSafeAreaLayoutGuide: Bool = false) -> Self {
        add(view, padding: 0, useSafeAreaLayoutGuide: useSafeAreaLayoutGuide)
        return self
    }

    @discardableResult
    func add(_ view: UIView,
             padding: CGFloat,
             useSafeAreaLayoutGuide: Bool = false) -> Self {
        let edgeInsets = DeclarativeEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        add(view, padding: edgeInsets, useSafeAreaLayoutGuide: useSafeAreaLayoutGuide)
        return self
    }

    @discardableResult
    func add(_ view: UIView,
             padding: DeclarativeEdgeInsets,
             useSafeAreaLayoutGuide: Bool = false) -> Self {
        addSubview(view)
        view.expand(to: self, padding: padding, useSafeAreaLayoutGuide: useSafeAreaLayoutGuide)
        return self
    }

    // MARK: - expand

    @discardableResult
    func expand(to view: UIView, useSafeAreaLayoutGuide: Bool = false) -> Self {
        expand(to: view, padding: 0, useSafeAreaLayoutGuide: useSafeAreaLayoutGuide)
        return self
    }

    @discardableResult
    func expand(to view: UIView, padding: CGFloat, useSafeAreaLayoutGuide: Bool = false) -> Self {
        let edgeInsets = DeclarativeEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        expand(to: view, padding: edgeInsets, useSafeAreaLayoutGuide: useSafeAreaLayoutGuide)
        return self
    }

    @discardableResult
    func expand(to view: UIView, padding: DeclarativeEdgeInsets, useSafeAreaLayoutGuide: Bool = false) -> Self {
        if #available(iOS 11.0, *) {
            let topAnchor = useSafeAreaLayoutGuide ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
            let leadingAnchor = useSafeAreaLayoutGuide ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor
            let trailingAnchor = useSafeAreaLayoutGuide ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor
            let bottomAnchor = useSafeAreaLayoutGuide ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor

            connect(\.topAnchor, to: topAnchor, padding: padding.top)
            connect(\.leadingAnchor, to: leadingAnchor, padding: padding.leading)
            connect(\.trailingAnchor, to: trailingAnchor, padding: -padding.trailing)
            connect(\.bottomAnchor, to: bottomAnchor, padding: -padding.bottom)
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
    func set(_ keyPath: KeyPath<UIView, NSLayoutDimension>,
             to constant: CGFloat,
             priority: UILayoutPriority = .required) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self[keyPath: keyPath].constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return self
    }

    @discardableResult
    func set(_ keyPath: KeyPath<UIView, NSLayoutDimension>,
             greaterThanOrEqualTo constant: CGFloat,
             priority: UILayoutPriority = .required) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self[keyPath: keyPath].constraint(greaterThanOrEqualToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
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
    func childPadding(_ value: DeclarativeEdgeInsets,
                      useSafeAreaLayoutGuide: Bool = true) -> Self {
        guard let child = subviews.first else { return self }
        child.removeFromSuperview()
        add(child, padding: value, useSafeAreaLayoutGuide: useSafeAreaLayoutGuide)
        return self
    }

    @discardableResult
    func padding(_ edges: DeclarativeEdgeInsets.Set,
                 _ value: CGFloat) -> UIView {
        UIView()
            .add(self)
            .childPadding(DeclarativeEdgeInsets(edges, value),
                          useSafeAreaLayoutGuide: true)
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

