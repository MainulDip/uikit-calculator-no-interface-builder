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
    var historyViewIsOpen: Bool
}

class ViewModel {
    
    struct vmConstants {
        static let allowedOperators = ["/", "*", "+", "-"]
        static let operatorRegexString = "\\+|\\-|X|\\/"
    }
    
    // TODO: Sanitize the input, name it sanitizeInput
    /*
     - if equation contain any operator at the first, don't allow that input
     - don't allow more than one `0` at the start
     - if the 0 is not followed by a `.` or `1-9`, replace that with following int
     - if starts with `.` then prepend with `0` as `0.`
     - don't allow putting operator just after one without following any number, in that case, remove the previous one
     */
    
    
    var state: ViewModelState
    
    init(state: ViewModelState = .init(equation: "", result: "", historyViewIsOpen: false)) {
        self.state = state
    }
    
    
    func didSelectButton(type: String, callBack: @escaping (ViewModelState) -> Void) {
        switch type {
        case "C":
            state.equation = ""
            state.result = ""
            break
        case "+","-","X","/":
            // TODO: if last input was also any of these, replace that with new one
//            let sanitizedInput = sanitizeInput(type, currentEqState: state.equation)
//            state.equation = state.equation + type.lowercased()
            state.equation = sanitizeOperator(type, currentEqState: state.equation)
//            computeEquation()
            break
            
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".":
            //
            // grab the type (value) and append that into the state.equation
//            let sanitizedInput = sanitizeInput(type, currentEqState: state.equation)
            // do it like `state.equation = sanitizedInput(type)`
//            state.equation = state.equation + type
            state.equation = sanitizeInput(type, currentEqState: state.equation)
             computeEquation()
            
            break
            
            
        case "left-delete-btn":
            let tempEquation = state.equation.dropLast()
            state.equation = String(tempEquation)
            computeEquation()
            break
            
        case "=":
            // TODO: Set the result as equation and clear the result
            state.equation = state.result
            state.result = ""
            break
            
        case "history-btn":
            
            state.historyViewIsOpen.toggle()
            break
            
        case "rotate-btn":
            
            break
        default:
            break
        }
        //update the state
        
        // TODO: Update the pre-equation as result this time
        
        //call the call back for the view
        callBack(state)
    }
    
    private func updateEquation(value: String) -> String {
        // convert the equation into an array
        // or just concatinate
        
        return ""
    }
    
    // func
    
    
    
    
    // TODO: -
    /*
     1. Equation Function
     - Convert String Into Array and Detect For operators /, *, + and - (sequentially)
     - make new array form left and right strings from each operator
     - Convert those strings into float except operators
     
     - ["12/12"] => let left: float = 12.0, right: Float = 12.0 => let devideEQ: Float = left / right
     
     * Alternate
     => extract the operators and build tuple/s like (operator: "/", position: Int)
     => then convert all the remaining stirng array into float array
     => and build => let eq: Float = 12 + 12 * 12 / 12 - 12
     =>
     */
    
    private func computeEquation() {
        // TODO: only starts computation for valid equation
        /*
         - if equation has an operator follewed by an Int/Float
         */
        
        do {
            let resF = try calculateFromString(equation: state.equation)
            state.result = "\(resF)"
        } catch {
            print(error)
        }
        
        
        
        
        //        var build = addFn(1,1)
        let f: Float = 2
        let sth: Float = f.addFn(rhs: 2).devideFn(rhs: 2)
        // TODO: How To Implement Chained Function's Priority as implemented in core swift operator
        print(sth)
        
        // var x = (*) // how to store operator into a variable
        print("")
    }
}


// MARK: - Equation State Sanitizer Helpers
extension ViewModel {
    private func sanitizeInput(_ input: String, currentEqState: String) -> String {
        
        var sanitizedState: String = ""
        
        // if starts with `.` then prepend with `0` as `0.`
        if (input == "." && currentEqState.count == 0) {
            return "0."
        }
        
        // if equation contain a floating point already, don't allow another `.` input
        if (input == "." && currentEqState.contains(/\./)) {
            print("contains . already")
            return currentEqState
        }
        
        // don't allow more than one `0` at the start
        if (input == "0" && currentEqState.last == "0" && currentEqState.count == 1) {
            sanitizedState = "0"
            return sanitizedState
        }
        
        // the first input is `0` and followed by anything other than `.` will replace the `0` from the first
        if (input != "0" && input != "." && currentEqState.last == "0" && currentEqState.count == 1 ) {
            print("it's not 0 and not .")
            return input
        }
        
        
        sanitizedState = currentEqState + input

        return sanitizedState
    }
    
    // Sanitize operator
    private func sanitizeOperator(_ op: String, currentEqState: String) -> String {
        
        // if the equation count is 0, don't allow operator as first input
        
        if (currentEqState.count == 0) {
            return currentEqState
        }
        
        // don't allow placeing operator after `.`
        if(currentEqState.last == ".") {
            return String(currentEqState.dropLast()) + op.lowercased()
        }
        
        // if last input was an operator replace that with new
        var tempEqState: String = ""
        var isLastAnOperator = false
        
        do {
            let allowedOperatorRegex = try Regex(vmConstants.operatorRegexString)
            isLastAnOperator = currentEqState.last != nil && String(currentEqState.last!).contains(allowedOperatorRegex)
        } catch {
            print("Regex error \(error)")
        }
        
        if (isLastAnOperator) {
            tempEqState = String(currentEqState.dropLast()) + op.lowercased()
        } else {
            return currentEqState + op.lowercased()
        }
        
        return tempEqState
    }
}

// MARK: Final Claculation Function

extension ViewModel {
    func compute(type: EqOperator, lhs: Decimal, rhs: Decimal) -> Decimal {
        switch type {
            
        case .add:
            print("from switch + \(lhs) + \(rhs) = \(lhs + rhs)")
            return lhs + rhs
        case .subtract:
            print("from switch - \(lhs) - \(rhs) = \(lhs - rhs)")
            return lhs - rhs
        case .multiply:
            print("from switch x \(lhs) * \(rhs) = \(lhs * rhs)")
            return lhs * rhs
        case .divide:
            return lhs / rhs
        }
    }
    
    func calculateFromString(equation: String) throws -> Decimal {
        if !equation.contains(EqOperator.allowedOps) {
            return Decimal(string: equation)!
        }
        
        var type: EqOperator?
        
        if equation.contains(EqOperator.add.rawValue) {
            type = EqOperator.add
        } else if equation.contains(EqOperator.subtract.rawValue) {
            type = EqOperator.subtract
        } else if equation.contains(EqOperator.multiply.rawValue) {
            type = EqOperator.multiply
        } else if equation.contains(EqOperator.divide.rawValue) {
            type = EqOperator.divide
        }
        
        guard let type = type else { fatalError("Something went wrong into the computation function") }
        
        let split = equation.split(separator: type.rawValue, maxSplits: 1, omittingEmptySubsequences: false)
        let lhs = String(split[0])
        let rhs = String(split[1])
        
        return compute(type: type, lhs: try calculateFromString(equation: lhs), rhs: try calculateFromString(equation: rhs))
    }
}



// MARK: - Float Extensions For Method Chaining

extension Float {
    
    func addFn(rhs: Float) -> Float {
        return self + rhs
    }
    
    func multiplyFn(rhs: Float) -> Float {
        return self * rhs
    }
    
    func devideFn(rhs: Float) -> Float {
        return self / rhs
    }
    
    func substractFn(rhs: Float) -> Float {
        return self - rhs
    }
    
    //    var addFn: (y: Float) -> Float { return self + y }
    //    var multiplyFn: (Float, Float) -> Float = (*)
    //    var devideFn: (Float, Float) -> Float = (/)
    
    // TODO: Expected Use Case
    // let eq = 12.0.addFn(12.0).multiplyFn(12.0) // as for > 12.0 + 12.0 * 12.0
    
    // ask ai : I would like to write a function in Swift that will be called by "12.0.addFn(12.00)" and will return a Float
}
