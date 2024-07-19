//
//  DeclarativeEdgeInsets.swift
//
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import Foundation

public struct DeclarativeEdgeInsets {
    let top: CGFloat
    let leading: CGFloat
    let bottom: CGFloat
    let trailing: CGFloat

    public struct Set: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public init(_ set: DeclarativeEdgeInsets.Set) {
            self.init(rawValue: set.rawValue)
        }

        public static let top = Set(rawValue: 1 << 0)
        public static let leading = Set(rawValue: 1 << 1)
        public static let trailing = Set(rawValue: 1 << 2)
        public static let bottom = Set(rawValue: 1 << 3)

        public static let horizontal: Set = [.leading, .trailing]
        public static let vertical: Set = [.top, .bottom]
        public static let all: Set = [.horizontal, .vertical]
    }

    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
}

extension DeclarativeEdgeInsets {
    init(_ set: DeclarativeEdgeInsets.Set, _ value: CGFloat) {
        self.init(top: set.contains(.top) ? value : 0,
                  leading: set.contains(.leading) ? value : 0,
                  bottom: set.contains(.bottom) ? value : 0,
                  trailing: set.contains(.trailing) ? value : 0)
    }
}
