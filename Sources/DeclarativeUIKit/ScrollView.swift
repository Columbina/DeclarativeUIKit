//
//  Created by Eduardo Domene Junior on 02.07.23.
//

import UIKit

/**
 Based on the [ScrollView](https://developer.apple.com/documentation/swiftui/scrollview) from SwiftUI.
 */
public final class ScrollView: UIScrollView {
    public struct AxisSet: OptionSet {
        public let rawValue: Int8

        public static let horizontal = AxisSet(rawValue: 1 << 0)
        public static let vertical = AxisSet(rawValue: 1 << 1)
        public static let all: AxisSet = [.horizontal, .vertical]

        public init(rawValue: Int8) {
            self.rawValue = rawValue
        }
    }

    public init(_ axis: AxisSet = .all, _ contentBuilder: () -> UIView?) {
        super.init(frame: .zero)
        if let content = contentBuilder() {
            add(content)

            // In case the ScrollView should scroll
            // to both directions, we don't need to
            // add any constraint
            if axis.contains(.all) {
                return
            }

            if axis.contains(.vertical) {
                content.connect(\.widthAnchor, to: widthAnchor)
                return
            }

            if axis.contains(.horizontal) {
                content.connect(\.heightAnchor, to: heightAnchor)
                return
            }
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension ScrollView {
    @discardableResult
    func showsVerticalScrollIndicator(_ shouldShow: Bool) -> Self {
        showsVerticalScrollIndicator = shouldShow
        return self
    }

    @discardableResult
    func showsHorizontalScrollIndicator(_ shouldShow: Bool) -> Self {
        showsHorizontalScrollIndicator = shouldShow
        return self
    }
}
