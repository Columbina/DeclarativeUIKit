//
//  Created by Eduardo Domene Junior on 29.06.23.
//

import Foundation
import UIKit

/// Based on [equivalent SwiftUI component ](https://developer.apple.com/documentation/swiftui/foreach).
///
/// Allows creating multiple views using DSL language.
/// e.g.:
/// ```swift
/// let list = ["Mango", "Banana", "Apple"]
///
/// var view: UIView {
///     VerticalStack {
///         ForEach(list) { item in
///             UILabel().text("Fruit:")
///             UILabel().text(item)
///         }
///     }
/// }
/// ```
public struct ForEach {
    public var views: [UIView]

    public init(views: [UIView]) {
        self.views = views
    }
}
