//
//  UITableView+Extensions.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 11.07.2022.
//

import UIKit

extension NSObject {
  public static var identifier: String {
    String(describing: self)
  }
}

extension UITableView {

  /// Register nib cell
  /// - Parameter cell: nib cell to register
  public func register(_ cell: UITableViewCell.Type) {
    let nib = UINib(nibName: cell.identifier, bundle: nil)
    register(nib, forCellReuseIdentifier: cell.identifier)
  }

  /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
  /// - Parameters:
  ///   - class: object type
  ///   - indexPath: current index path
  ///   - configure: handler for configuration
  /// - Returns: result cell
  public func dequeueReusableCell<T: UITableViewCell>(of class: T.Type,
                                                      for indexPath: IndexPath,
                                                      configure: ((T) -> Void)? = nil) -> UITableViewCell {
    let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
    if let typedCell = cell as? T {
      configure?(typedCell)
    }
    return cell
  }
}
