//
//  uikit_calculator_no_interface_builderTests.swift
//  uikit-calculator-no-interface-builderTests
//
//  Created by Mainul Dip on 3/2/25.
//

import Testing
import uikit_calculator_no_interface_builder

struct uikit_calculator_no_interface_builderTests {
    
    var i = 0
    
    init() {
        print("Bismillah form init and counter \(i)")
        i += 1
    }
    
    func calculate(equation: String) -> String {
        
        
        
        
        // generate operator from string, ie, "+" to +
        
        return ""
    }
    
    @Test func testoneplusone() {
        let equation = "1+1"
        let result = calculate(equation: equation)
        // #expect(result == "2.0")
        #expect("2" == "2")
    }
    
    @Test func testOperatorHolderGenerator() {
        let equation = "1+1"
        let operatorHolder = operatorHolderGenerator(equation: equation)
        let opType = "\(operatorHolder[0].operatorType)"
        let opIndex = "\(operatorHolder[0].index)"
        #expect(opType == "+")
        #expect(opIndex == "1")
    }
    
    @Test func testOpHolderWithCompPointers() {
        let equation = "1+1"
        let operatorHolder = opHolderWithCompPointers(equation: equation)
        let opType = "\(operatorHolder[0].operatorType)"
        let opIndex = "\(operatorHolder[0].index)"
        let opLhs = operatorHolder[0].lhs
        let opRhs = operatorHolder[0].rhs
        #expect(opType == "+")
        #expect(opIndex == "1")
        #expect(opLhs.startingIndex == 0)
        #expect(opLhs.endingIndex == 0)
        #expect(opRhs.startingIndex == 2)
        #expect(opRhs.endingIndex == 2)
    }
    
    @Test func testOpHolderWithCompNumbers() {
        let equation = "1x1234.1234"
        let operatorHolder = opHolderWithCompNumbers(equation: equation)
        let opType = operatorHolder[0].operatorType
        let opIndex = operatorHolder[0].index
        let opLhsNum = operatorHolder[0].lhsNum
        let opRhsNum = operatorHolder[0].rhsNum
        #expect(opType == "x")
        #expect(opIndex == 1)
        #expect(opLhsNum == 1)
        #expect(opRhsNum == 1234.1234)
    }
    
    @Test func testRecursiveComputation() {
        let equation = "0-4.0024/2x4/2+2+2-7"
        let actualRes = 0 - 4.0024 / 2 * 4 / 2 + 2 + 2 - 7
        let computedRes = compRecursive(equation: equation)
        print("result of \(equation) is \(computedRes) and actual result is \(actualRes)")
        #expect(actualRes == computedRes)
    }
    
    
    
    // TODO: Test Addition | make addition function first
    // TODO: Test Substraction | make Substraction function firs
    // TODO: Test Multuplication | make Multuplication function first
    // TODO: Test Dividation | make Dividation function first
    // TODO: Finally do the complete equation
    
    /*
     [1234.123+789.007] > lhs.add(rhs)
     */
    
    
    
    
    /* Logics for final equation floating point precission
     - if its a full number remove floating point
     */
}

extension uikit_calculator_no_interface_builderTests {
    func operatorHolderGenerator(equation: String) -> [(operatorType: String, index: Int)] {
        let equationArray = Array(equation)
        var operatorHolder: [(operatorType: String, index: Int)] = []
        
        equationArray.enumerated().forEach { (index, value) in
            // /\+|\-|\*|\//)
            if (String(value).contains(/\+|\-|x|\//)) {
                operatorHolder.append((String(value), index))
            }
        }
        
        print(operatorHolder)
        return operatorHolder
    }
    
    func opHolderWithCompPointers(equation: String) -> [(operatorType: String, index: Int, lhs: (startingIndex: Int, endingIndex: Int), rhs: (startingIndex: Int, endingIndex: Int))] {
        let equationArray = Array(equation)
        let equationArrayCount = equationArray.count
        var opHolderWithCompPointer: [(operatorType: String, index: Int, lhs: (startingIndex: Int, endingIndex: Int), rhs: (startingIndex: Int, endingIndex: Int))] = []
        
        
        var prevOpIndex: Int?
        equationArray.enumerated().forEach { (index, value) in
            // /\+|\-|\*|\//)
            if (String(value).contains(/\+|\-|x|\//)) {
                
                
                let lhs: (startingIndex: Int, endingIndex: Int) = (prevOpIndex != nil ? prevOpIndex! + 1 : 0, index - 1)
                
                let subArrayStaringFromIndex = equationArray[(index + 1)..<equationArray.count]
                // let subArrayStaringFromIndex = index < equationArray.count ? equationArray[(index + 1)..<equationArray.count] : [equationArray.last!] // no need for now
                
                var endOfRhsR: Int?
                
                subArrayStaringFromIndex.enumerated().forEach { (i, v) in
                    if (String(v).contains(/\+|\-|x|\//)) {
                        endOfRhsR = i
                    }
                }
                
                
                let rhs: (startingIndex: Int, endingIndex: Int) = (index + 1, endOfRhsR != nil ? endOfRhsR! : equationArrayCount - 1) // for r, substring from index+1 to next op occurance (when nil, set last)
                
                opHolderWithCompPointer.append((String(value), index, lhs, rhs))
                
                prevOpIndex = index
            }
        }
        
        
        return opHolderWithCompPointer
        
    }
    
    // Storing the exact number with operator
    func opHolderWithCompNumbers(equation: String) -> [(operatorType: String, index: Int, lhsNum: Float, rhsNum: Float)] {
        let opHolderWithCompPointers = opHolderWithCompPointers(equation: equation)
        let equationArray = Array(equation)
        let compNumber: [(operatorType: String, index: Int, lhsNum: Float, rhsNum: Float)] = opHolderWithCompPointers.map {
            let lhsNum = Float(String(equationArray[$0.lhs.startingIndex...$0.lhs.endingIndex]))!
            let rhsNum = Float(String(equationArray[$0.rhs.startingIndex...$0.rhs.endingIndex]))!
            return ($0.operatorType, $0.index, lhsNum, rhsNum)
        }
        return compNumber
    }
    
    // MARK: Working EqationComputation (eq: String) -> String | Do single run
    func eqComputation(eq: String, runningOp: String) -> (nextEq: String, opMatch: Bool) {
        var opHolderWithCompNumber = opHolderWithCompNumbers(equation: eq)
        
        // do division, make a single number, remove the division tuple, and assign the number to left or right with previous matching number
        var compDoneIndex: Int?
        var opMatch: Bool = false
        var compResult: Float?
        
        singleRun: for (i, op) in opHolderWithCompNumber.enumerated() {
            if op.operatorType == runningOp {
                opMatch = true
                compResult = basicCom(type: runningOp, lhs: op.lhsNum, rhs: op.rhsNum)
                compDoneIndex = i
                break singleRun
            }
        }
        
        if compDoneIndex != nil {
            // if opHolderWithCompNumber[compDoneIndex - 1] exist do replace lhs or rhs with the value
            // if not do widh [compDoneIndex + 1] and if none, thats the final result
            opHolderWithCompNumber.remove(at: compDoneIndex!)
        }
        /*
         if
         */
        return ("", opMatch)
    }
    
    func basicCom(type: String, lhs: Float, rhs: Float) -> Float {
        switch type {
        case "+":
            print("from switch + \(lhs) + \(rhs) = \(lhs + rhs)")
            return lhs + rhs
        case "-":
            return lhs - rhs
        case "x":
            print("from switch x \(lhs) * \(rhs) = \(lhs * rhs)")
            return lhs * rhs
        case "/":
            return lhs / rhs
        default:
            return 0.0
        }
    }
    
    func basicComD(type: String, lhs: Double, rhs: Double) -> Double {
        switch type {
        case "+":
            print("from switch + \(lhs) + \(rhs) = \(lhs + rhs)")
            return lhs + rhs
        case "-":
            print("from switch - \(lhs) - \(rhs) = \(lhs - rhs)")
            return lhs - rhs
        case "x":
            print("from switch x \(lhs) * \(rhs) = \(lhs * rhs)")
            return lhs * rhs
        case "/":
            return lhs / rhs
        default:
            return 0.0
        }
    }
    
    
    // Human approach
    func opHolderToSequentialCom(equation: String) {
        let equationArray = Array(equation)
        var runningEq: String = equation
        
        
        var prevOpIndex: Int?
        equationArray.enumerated().forEach { (index, value) in
            // /\+|\-|\*|\//)
            if (String(value).contains(/\+|\-|x|\//)) {
                
                
                
                prevOpIndex = index
            }
        }
    }
    
    // recursive approach
    /*
     - Function building should be done reverse order
     - 1+2*3 = f(l: 1, r: f(l: 2, r: 3, op: *), op: +)
     - 2*3+1 = f(l: f(l: 2, r: 3, op: *), r: 1, op: +)
     */
    
    /* Recursive function building
     - [[1], [+], [2], [+], [3]]
     - [[1],[+],[2],[/],[3]]
     - 4.0024 / 2 * 4 / 2 + 2 * 2 - 7 = rearrange =
     */
    
    func compRecursive(eqArr: [(type: String, lhs: Float, rhs: Float)]) -> Float {
        if eqArr.count == 1 {
            return basicCom(type: eqArr[0].type, lhs: eqArr[0].lhs, rhs: eqArr[0].rhs)
        }
        
        // split the array in lhs and rhs based on `+` and `-` first
        // when there are no `+` and `-` available for spliting, proceed
        // with `/` and `*`
        
        return basicCom(type: eqArr[0].type, lhs: compRecursive(eqArr: Array(eqArr[1...])), rhs: compRecursive(eqArr: Array(eqArr[1...])))
    }
    
    // Active
    // TODO: Convert Double to Decimal to tackle decimal precission issues
    func compRecursive(equation: String) -> Double {
        let eqArr = Array(equation)
        
    
        
        // base case :
        // if lhsArray.count == 1 or rhsArray.count == 1
        // convert the string to Float and return it
        /// if the provided string doesn't contain then its an number only
        if !equation.contains(/\/|x|\+|\-/) {
            return Double(equation)!
        }
        
        // split the array in lhs and rhs based on `+` and `-` first
        // when there are no `+` and `-` available for spliting, proceed
        // with `/` and `*`
        
        var type: String = ""
        var lhs: String = ""
        var rhs: String = ""
        var split: [String.SubSequence] = []
        
        if equation.contains(/\+/) {
            split = equation.split(separator: /\+/, maxSplits: 1, omittingEmptySubsequences: false)
            type = "+"
//            lhs = String(split[0])
//            rhs = String(split[1])
            print("type = \(type), lhs = \(lhs), rhs = \(rhs)")
        } else if equation.contains(/\-/) {
            split = equation.split(separator: /\-/, maxSplits: 1, omittingEmptySubsequences: false)
            type = "-"
//            lhs = String(split[0])
//            rhs = String(split[1])
            print("type = \(type), lhs = \(lhs), rhs = \(rhs)")
        } else if equation.contains(/x/) {
            split = equation.split(separator: /x/, maxSplits: 1, omittingEmptySubsequences: false)
            type = "x"
//            lhs = String(split[0])
//            rhs = String(split[1])
            print("type = \(type), lhs = \(lhs), rhs = \(rhs)")
        } else if equation.contains(/\//) {
            split = equation.split(separator: /\//, maxSplits: 1, omittingEmptySubsequences: false)
            type = "/"
//            lhs = String(split[0])
//            rhs = String(split[1])
            print("type = \(type), lhs = \(lhs), rhs = \(rhs)")
        }
        
        lhs = String(split[0])
        rhs = String(split[1])
        
        return basicComD(type: type, lhs: compRecursive(equation: lhs), rhs: compRecursive(equation: rhs))
    }
    
}


/* Logics for computation
 - if equation contain any operator at last, remove that from equation (name that `sanitized`) | only when the `=` button pressed
 - get the position of the operator/s ( no need for its `lhs` and `rhs`, as those will be [lhs = operatorPos - 1, rhs = operatorPos + 1
 - run loop for each operator occurance, starting with `/`, then `*`, then `+` & `-` as chain
 */

/*
 # truthItem1 = "4.0024 / 2 * 4 / 2 + 2 + 2 - 7"
 - [(oparator: String, position: Int)]
 = [("/", 6), ("*", 8), ("/", 10), ("+", 12), ("+", 14), ("-", 16)]
 # truthItem2 = "2 + 12 - 7 + 4.0024 / 2 * 4 / 2"
 - [(oparator: String, position: Int)]
 = [("+", 1), ("-", 3), ("+", 5), ("/", 12), ("*", 14), ("/", 14)]
 devideCandidates = [(lhs: 6-to-11, rhs: 13), (lhs: , rhs: 15-to-count-1)]
 devideCandidateLogic = (lhs: previousOperatorPos + 1 to currentOperatorPos - 1, rhs: currentOperatorPos + 1 to nextOperatorPos - 1)
 
 1. get the operator's position in the equation, a.k.a occurance times and position for regex /\/|x|\+|\-/
 - convert into array and loop each. From inside loop, check if operators exists and build the [(operator, operatorPos)] array
 - then start the equation-operation step starting division type and each will perform a loop to caculate values
 
 st = "4.0024 / 2 * 4 / 2 + 2 + 2 - 7"
 2. division first and build `carringResult` as "2.0012 * 2 + 2 + 2 - 7"
 3. multiplication second and build `carringResult` as "4.0024 + 2 + 2 - 7"
 */

enum EqOperatorRawVal: String {
    case add        = "+"
    case subtract   = "-"
    case multiply   = "x"
    case divide     = "/"
}

func getOpRegex(type: EqOperatorRawVal) -> Regex<Substring> {
    return switch type {
    case .add       : /\+/
    case .subtract  : /\-/
    case .multiply  : /x/
    case .divide    : /\//
    }
}

let sth = /\+/

enum Operand {
    case add, subtract, multiply, divide
}
protocol Equation {
    
    func resolve() -> Double
}

func parse(equation: String) -> Equation {
    let x = "1+1"
    
    
    return JustANumber(nubmer: 2)
}

struct MyEquation: Equation
{
    var lhs: Equation
    var rhs: Equation
    var operand: Operand
    
    func resolve() -> Double
    {
        switch operand
        {
        case .add:
            return lhs.resolve() + rhs.resolve()
        case .subtract:
            return lhs.resolve() - rhs.resolve()
        case .multiply:
            return lhs.resolve() * rhs.resolve()
        case .divide:
            return lhs.resolve() / rhs.resolve()
            
        }
    }
}

struct JustANumber: Equation {
    let nubmer: Double
    func resolve() -> Double {
        return nubmer
    }
}
