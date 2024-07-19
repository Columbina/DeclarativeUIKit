//
//  Created by Eduardo Domene Junior on 29.06.23.
//

import UIKit

public protocol ViewsConvertible {
    func asViews() -> [UIView]
}

extension UIView: ViewsConvertible {
    public func asViews() -> [UIView] {
        [self]
    }
}

extension UIViewController: ViewsConvertible {
    public func asViews() -> [UIView] {
        [
            ViewControllerHost {
                self
            }
        ]
    }
}

extension Optional: ViewsConvertible where Wrapped: UIView {
    public func asViews() -> [UIView] {
        []
    }
}

extension ViewsGroup: ViewsConvertible {
    func asViews() -> [UIView] {
        views
    }
}

extension [UIView]: ViewsConvertible {
    public func asViews() -> [UIView] {
        self
    }
}

extension ForEach: ViewsConvertible {
    public func asViews() -> [UIView] {
        views
    }
}
