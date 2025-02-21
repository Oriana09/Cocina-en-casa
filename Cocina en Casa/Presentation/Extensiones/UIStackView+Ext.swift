//
//  UIStackView+Ext.swift
//  Cocina en Casa
//
//  Created by Oriana Costancio on 21/02/2025.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
//        /*views.forEach { addArrangedSubview($0) */}
        for view in views { addArrangedSubview(view) }
    }
}
