//
//  ViewController.swift
//  Caculator
//
//  Created by liubin on 15/6/12.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isInInitZeroState = true
    
    var operandStack: Array<Double> = []
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isInInitZeroState {
            display.text = digit
            isInInitZeroState = false
        } else {
            display.text = display.text! + digit
        }
    }
    
    @IBAction func enter() {
        if isInInitZeroState {
            return
        }
        operandStack.append(displayValue)
        isInInitZeroState = true
        NSLog("operandStack: \(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton) {
        enter()

        let operatorName = sender.currentTitle!
        switch operatorName {
        case "+":
            performOperation({$0 + $1})
        case "−":
            performOperation({$1 - $0})
        case "×":
            performOperation({$0 * $1})
        case "÷":
            performOperation({$1 + $0})
        case "√":
            performOperation({sqrt($0)})
        default:
            break
        }
        
        
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count < 2 {
            return
        }
        let result = operation(operandStack.removeLast(), operandStack.removeLast())
        operandStack.append(result)
        displayValue = result
    }
    

    private func performOperation(operation: Double -> Double) {
        if operandStack.count < 1 {
            return
        }
        let result = operation(operandStack.removeLast())
        operandStack.append(result)
        displayValue = result

    }
    
}

