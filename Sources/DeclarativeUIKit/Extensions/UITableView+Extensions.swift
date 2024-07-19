import UIKit

public extension UITableView {
    @discardableResult
    func registerCell(_ cell: AnyClass, forCellReuseIdentifier identifier: String) -> Self {
        register(cell, forCellReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func registerCell(_ cell: AnyClass, forHeaderFooterViewReuseIdentifier identifier: String) -> Self {
        register(cell, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }

    @discardableResult
    func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func allowsSelection(_ allowsSelection: Bool) -> Self {
        self.allowsSelection = allowsSelection
        return self
    }

    @discardableResult
    func isScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }

    @discardableResult
    func separatorStyle(_ separatorStyle: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = separatorStyle
        return self
    }
}
