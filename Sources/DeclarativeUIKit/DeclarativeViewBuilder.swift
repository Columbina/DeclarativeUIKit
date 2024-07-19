//
//  Created by Eduardo Domene Junior on 29.06.23.
//

import UIKit

@resultBuilder
public enum DeclarativeViewBuilder {
    static func buildBlock() -> [UIView] { [] }
}

public extension DeclarativeViewBuilder {
    static func buildBlock(_ values: ViewsConvertible...) -> [UIView] {
        values.flatMap { $0.asViews() }
    }

    static func buildIf(_ value: ViewsConvertible?) -> ViewsConvertible {
        value ?? []
    }

    static func buildEither(first: ViewsConvertible) -> ViewsConvertible {
        first
    }

    static func buildEither(second: ViewsConvertible) -> ViewsConvertible {
        second
    }
}

// MARK: - DeclarativeViewBuilder Conformance

public extension VerticalStack {
    convenience init(@DeclarativeViewBuilder builder: () -> [UIView]) {
        self.init()
        forEach(builder()) { view in
            view
        }
    }
}

public extension HorizontalStack {
    convenience init(@DeclarativeViewBuilder builder: () -> [UIView]) {
        self.init()
        forEach(builder()) { view in
            view
        }
    }
}

public extension ForEach {
    init(@DeclarativeViewBuilder builder: () -> [UIView]) {
        self.init(views: builder())
    }

    init<Data>(_ collection: Data, @DeclarativeViewBuilder builder: (Data.Element) -> [UIView]) where Data: RandomAccessCollection {
        self.init(views: collection.flatMap { builder($0) })
    }
}

struct ViewsGroup {
    var views: [UIView]

    init(@DeclarativeViewBuilder builder: () -> [UIView]) {
        views = builder()
    }
}
