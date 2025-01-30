//
//  UIButtonRound.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 1/25/25.
//

import UIKit

class UIButtonRound: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        // implementing corner radius
        layer.cornerRadius = bounds.height / 2
        
    }
}
