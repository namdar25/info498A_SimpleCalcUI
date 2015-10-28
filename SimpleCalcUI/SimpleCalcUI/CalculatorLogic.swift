//
//  CalculatorLogic.swift
//  SimpleCalcUI
//
//  Created by Shawn Namdar on 10/22/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import Foundation

enum CalculatorType {
    case RPN
    case Standard
}

var operatorArray: [String] = ["+","-","*","/","%"]
var functionArray: [String] = ["Count","AVG","!"]
var equals: String = "="

func parse(stringEquation: String) -> [String] {
    var equation: [String] = []
    equation = stringEquation.componentsSeparatedByString(" ")
    return equation
    
}

func add(equation: [String]) -> String {
    return "\(Float(equation[0])! + Float(equation[2])!)"
}

func subtract(equation: [String]) -> String {
    return "\(Float(equation[0])! - Float(equation[2])!)"
}

func multiply(equation: [String]) -> String {
    return "\(Float(equation[0])! * Float(equation[2])!)"
}

func divide(equation: [String]) -> String {
    return "\(Float(equation[0])! / Float(equation[2])!)"
}

func mod(equation: [String]) -> String {
    return "\(Float(equation[0])! % Float(equation[2])!)"
}

func factorial(equation: [String]) -> String {
    var answer: Float = Float(equation[0])!
    for var index = answer-1; index > 0; --index {
        answer = answer * index
    }
    return "\(answer)"
}

func count(equation: [String], calculatorType: CalculatorType) -> String {
    var answer: Int
    if calculatorType == CalculatorType.Standard{
        answer = equation.count / 2
    } else {
        answer = equation.count - 2
    }
    return "\(answer)"
}

func avg(equation: [String], calculatorType: CalculatorType) -> String {
    let equationCount = Int(count(equation, calculatorType: calculatorType))!
    var answer: Float = Float(equation[0])!
    for var index = 1; index < equation.count; ++index {
        if equation[index] != "AVG" && equation[index] != "" {
            answer += Float(equation[index])!
        }
    }
    return "\(answer / Float(equationCount))"
}

func reorderBasic(var equation: [String]) -> [String] {
    let number2: String = equation[2]
    equation[2] = equation[1]
    equation[1] = number2
    return equation
}

func solve(stringEquation: String, calculatorType: CalculatorType) -> String {
    let answer: String = ""
    var equation: [String] = parse(stringEquation)
    switch calculatorType {
    case .Standard:
        switch equation[1] {
        case "+":
            return add(equation)
        case "-":
                return subtract(equation)
        case "*":
            return multiply(equation)
        case "/":
            return divide(equation)
        case "%":
            return mod(equation)
        case "!":
            return factorial(equation)
        case "Count":
            return count(equation, calculatorType: .Standard)
        case "AVG":
            return avg(equation, calculatorType: .Standard)
        default:
            break
        }
    case .RPN:
        switch equation[equation.count - 1] {
        case "+":
            return add(reorderBasic(equation))
        case "-":
            return subtract(reorderBasic(equation))
        case "*":
            return multiply(reorderBasic(equation))
        case "/":
            return divide(reorderBasic(equation))
        case "%":
            return mod(reorderBasic(equation))
        case "!":
            return factorial(equation)
        case "Count":
            return count(equation, calculatorType: .RPN)
        case "AVG":
            return avg(equation, calculatorType: .RPN)
        default:
            break
        }
    }
    return answer
}

func okToAddNumber(stringToCheck: String, calculatorType: CalculatorType) -> Bool {
    var response: Bool = true
    var equation: [String] = parse(stringToCheck)
    if equation.count > 1 {
        switch calculatorType{
        case .RPN:
            return response
            /*for var index = 0; index < equation.count; ++index {
                let number = Float(equation[index])
            
                if number == nil {
                response = false
                }
            }*/
        case .Standard:
            if equation.count%2 == 0 {
                let number = Float(equation[equation.count-1])
                if number != nil {
                    response = false
                }
            }
        }
    }
 return response   
}

func okToAddOperator(stringToCheck: String, operatorToCheck: String, calculatorType: CalculatorType) -> Bool {
    let equation: [String] = parse(stringToCheck)
    if calculatorType == CalculatorType.RPN {
        if equation.count < 3 {
            return false
        }
        return true
    }
    if equation.count%2 == 1{
        if equation.count == 1 {
            return true
        } else {
            if equation.contains(operatorToCheck) {
                return true
            } else {
                return false
            }
        }
    }
    return false
}

func okToAddFunction(stringToCheck: String, functionToCheck: String, calculatorType: CalculatorType) -> Bool {
    let equation: [String] = parse(stringToCheck)
    if calculatorType == CalculatorType.RPN {
        if equation.count < 2 {
            return false
        }
        return true
    }
    if equation.count%2 == 1{
        if equation.count == 1 {
            return true
        } else {
            if equation.contains(functionToCheck) {
                return true
            } else {
                return false
            }
        }
    }
    return false
}
