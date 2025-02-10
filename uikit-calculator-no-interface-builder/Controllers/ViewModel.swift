//
//  ViewModel.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 2/9/25.
//

import Foundation

struct ViewModelState {
    var equation: String
    var result: String
    
}

class ViewModel {
    var state: ViewModelState
    
    init(state: ViewModelState = .init(equation: "", result: "")) {
        self.state = state
    }

    
    func didSelectButton(type: String, callBack: @escaping (ViewModelState) -> Void) {
        switch type {
        case "C", "()", "%", "/":
            //Update equation based on input
            state.equation = "Hello world"
            break
        case "7", "8", "9", "X":
            //Update equation based on input
            state.equation = "Hello world"
            break
        case "4", "5", "6", "-":
            //Update equation based on input
            state.equation = "Hello world"
            break
        case "1", "2", "3", "4":
            //Update equation based on input
            state.equation = "Hello world"
            break
            
        case "+/-", "0", ".", "=":
            //Update equation based on input
            state.equation = "Hello world"
            break
        default:
            break
        }
        //update the state
        
        //call the call back for the view
        callBack(state)
    }
}
