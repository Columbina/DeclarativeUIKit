//
//  Created by Eduardo Domene Junior on 29.06.23.
//

import Foundation
import UIKit

/// A UIView that hosts a view controller.
///
/// Use a `ViewControllerHost` when you need to wrap a `UIViewController` into a view.
/// This class will automatically add the view controller as a child of its presenting view controller.
///
/// E.g.:
/// ```swift
/// var body: UIView {
///     VerticalStack {
///         UILabel().text("Hello world")
///         ViewControllerHost {
///             MyViewController()
///         }
///     }
/// }
/// ```
public final class ViewControllerHost: UIView {
    public init(_ content: () -> UIViewController) {
        super.init(frame: .zero)
        addContent(content())
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    public func addContent(_ viewController: UIViewController) -> Self {
        addContentAttempt(viewController, maxTries: 3, currentTry: 0)
        return self
    }

    // At the time we try to add the content, it's probable that the view doesn't have a parent yet,
    // hence the attempts, so we can actually wait for the parent to be set, and then we move
    // the content to the container.
    private func addContentAttempt(_ content: UIViewController, maxTries: Int, currentTry: Int) {
        guard currentTry < maxTries else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            guard let parent = self.parentViewController else {
                self.addContentAttempt(content, maxTries: maxTries, currentTry: currentTry + 1)
                return
            }

            parent.addChild(content)
            self.add(content.view)
            content.didMove(toParent: parent)
        }
    }
}
