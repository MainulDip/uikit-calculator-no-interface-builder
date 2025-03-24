//
//  EqOperatorEnum.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 3/23/25.
//

import Foundation

enum EqOperator: String, CaseIterable {
    case add        = "+"
    case subtract   = "-"
    case multiply   = "x"
    case divide     = "/"
    
    func getRegex(type: EqOperator) -> Regex<Substring> {
        return switch type {
        case .add       : /\+/
        case .subtract  : /\-/
        case .multiply  : /x/
        case .divide    : /\//
        }
    }
    
    static let allowedOps = /\/|x|\+|\-/
}
