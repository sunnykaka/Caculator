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
    
    let calculatorBrain = CalculatorBrain()
    
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
        calculatorBrain.pushOperand(displayValue)
        isInInitZeroState = true
    }
    
    @IBAction func operate(sender: UIButton) {
        enter()

        let operatorName = sender.currentTitle!
        if let result = calculatorBrain.performOperation(operatorName) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
        
    }
    
}

