//
//  Created by Eduardo Domene Junior on 02.07.23.
//

import Foundation
import UIKit

/// List is the equivalent version for [List in SwiftUI](https://developer.apple.com/documentation/swiftui/list).
///
/// ``DeclarativeUIKit/List`` works just like a table view, but it doesnt need a datasource. Instead, it uses the array passed to it in the initialization.
/// You can return any view that you want inside the builder closure, which will receive each item from the collection.
///
/// Different from ``DeclarativeUIKit/ForEach``, ``DeclarativeUIKit/List`` takes advantage of **reusable cells**.
///
/// E.g.:
///
/// ```swift
/// var oceans = [
///     Ocean(name: "Pacific"),
///     Ocean(name: "Atlantic"),
///     Ocean(name: "Indian"),
///     Ocean(name: "Southern"),
///     Ocean(name: "Arctic")
/// ]
///
/// var body: UIView {
///     List(oceans) {
///         UILabel.text($0.name)
///     }
/// }
/// ```
///
/// You can also add multiple views inside the List closure:
///
/// ```swift
/// var body: UIView {
///     List(oceans) { ocean in
///         UILabel.text("Ocean:")
///         MyCustomView(ocean: ocean)
///     }
/// }
/// ```
public final class List<Data>: UIView, UITableViewDelegate, UITableViewDataSource where Data: RandomAccessCollection {
    // MARK: - Private Properties

    private let collection: Data
    private let builder: (Data.Element) -> [UIView]

    private lazy var tableView: IntrinsicTableView = .init(frame: .zero)
        .dataSource(self)
        .delegate(self)
        .registerCell(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        .backgroundColor(.clear)

    // MARK: - Init

    public init(_ collection: Data, @DeclarativeViewBuilder builder: @escaping (Data.Element) -> [UIView]) {
        self.collection = collection
        self.builder = builder
        super.init(frame: .zero)
        add(tableView).backgroundColor(.white)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.set(compressionResistance: .defaultLow, for: .vertical)
        allowsSelection(false)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    public func allowsSelection(_ value: Bool) -> Self {
        tableView.allowsSelection = value
        return self
    }

    @discardableResult
    public func separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        tableView.separatorStyle = style
        return self
    }

    // MARK: - TableView Delegates

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        collection.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell else {
            return UITableViewCell()
        }

        // 1. Getting the element from the collection
        let itemIndex = collection.index(collection.startIndex, offsetBy: indexPath.row)
        let item = collection[itemIndex]

        // 2. Creating the view using the element
        /// Since the builder can return an array of views, we add them in a stack view.
        let view = VerticalStack {
            /// We call the builder when creating the cell in order to optimize memory usage.
            /// Otherwise, we would have to store all the pre-rendered views in the List,
            /// which would defeat the purpose of reusing the cells.
            builder(item)
        }

        // 3. Injecting the view into the cell
        cell.configureCell(with: view)
        cell.backgroundColor = .clear

        return cell
    }
}

public final class ListCell: UITableViewCell {
    static let identifier = String(describing: ListCell.self)

    public func configureCell(with view: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.add(view)
        accessibilityIdentifier = "ListCell"
    }
}

/// UITableViews cannot automatically calculate their intrinsic size if they don't receive a fixed height.
public final class IntrinsicTableView: UITableView {
    override public var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
