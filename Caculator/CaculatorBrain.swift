//
//  CaculatorBrain.swift
//  Caculator
//
//  Created by liubin on 15/6/17.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var opStack = [Op]()
    
    var knownSymbolMap = [
        "+" : Op.BinaryOperator("+", {$0 + $1}),
        "−" : Op.BinaryOperator("+", {$1 - $0}),
        "×" : Op.BinaryOperator("+", {$0 * $1}),
        "÷" : Op.BinaryOperator("+", {$1 / $0}),
        "√" : Op.UnaryOperator("√", sqrt)
    ]
    
    enum Op : Printable {
        case Operand(Double)
        case UnaryOperator(String, Double -> Double)
        case BinaryOperator(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand) "
                case .UnaryOperator(let symbol, _):
                    return " \(symbol) "
                case .BinaryOperator(let symbol, _):
                    return " \(symbol) "
                }
            }
        }

    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String) -> Double? {
        if let op = knownSymbolMap[symbol] {
            opStack.append(op)
            return evaluate()
        }
        return nil
    }
    
    func evaluate() -> Double? {
        println("opStack: \(opStack)")
        if !opStack.isEmpty {
            let evaluateResult = evaluate(opStack.removeLast(), remaining: opStack)
            if let result = evaluateResult.resultOperand {
                opStack = evaluateResult.remaining
                pushOperand(result)
            }
            return evaluateResult.resultOperand
        }
        return nil
    }
    
    func evaluate(op: Op, remaining: Array<Op>) ->
        (resultOperand: Double?, remaining: Array<Op>) {
        switch op {
        case .Operand(let operand):
            return (operand, remaining)
        case .UnaryOperator(_, let operation):
            if !remaining.isEmpty {
                var nextRemaning = remaining
                let evaluateResult = evaluate(nextRemaning.removeLast(), remaining: nextRemaning);
                if let result = evaluateResult.resultOperand {
                    return (operation(result), evaluateResult.remaining)
                }
            }
        case .BinaryOperator(_, let operation):
            if remaining.count > 1 {
                var nextRemaning = remaining
                let evaluateResult1 = evaluate(nextRemaning.removeLast(), remaining: nextRemaning);
                if let result1 = evaluateResult1.resultOperand {
                    var thirdRemaning = evaluateResult1.remaining
                    if !thirdRemaning.isEmpty {
                        let evaluateResult2 = evaluate(thirdRemaning.removeLast(), remaining: thirdRemaning);
                        if let result2 = evaluateResult2.resultOperand {
                            return (operation(result1, result2), remaining:evaluateResult2.remaining)
                        }

                    }
                }
            }
        }
        
        return (nil, remaining)
    }
    
    
    
}