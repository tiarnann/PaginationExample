//
//  UITableView+Registering.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeueResusableCell<CellType: UITableViewCell>(for indexPath: IndexPath) -> CellType {
        return self.dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as! CellType
    }
}

extension UITableViewCell {
    static var identifier: String {
        let id = String(describing: self)
        return id
    }
}
