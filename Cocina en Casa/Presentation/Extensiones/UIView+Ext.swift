//
//  UIView+Ext.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 18/11/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}

