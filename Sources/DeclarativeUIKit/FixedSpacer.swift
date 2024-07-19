//
//  Created by Eduardo Domene Junior on 29.06.23.
//

import Foundation
import UIKit

/// Fixed Spacer has a pre-defined height or width
public final class FixedSpacer: UIView {
    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        super.init(frame: .zero)

        if let width {
            set(\.widthAnchor, to: width)
        }

        if let height {
            set(\.heightAnchor, to: height)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
