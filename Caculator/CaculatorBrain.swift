//
//  CaculatorBrain.swift
//  Caculator
//
//  Created by liubin on 15/6/17.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var opStack = [Op]()
    
    var knownSymbolMap = [String:Op]()
    
    enum Op {
        case Operand(Double)
        case unaryOperator(String, Double -> Double)
        case binaryOperator(String, (Double, Double) -> Double)
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return 0
    }
    
    func performOperation(symbol: String) -> Double? {
        if let op = knownSymbolMap[symbol] {
            opStack.append(op)
        }
        return 0
    }

    
    func evaluate() -> Double? {
        return 0
    }
    
    
    
}