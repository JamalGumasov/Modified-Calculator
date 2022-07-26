//
//  ViewController.swift
//  Calculator
//
//  Created by Джамал Гумасов on 26.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    private var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var display: UILabel!
    
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }

    var isTypingDigit = false, decimalIsTouched = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
     
        
        let displayText = display.text!
        
        var touchedDigit = String()
        
        let whatIsTouched = sender.currentTitle!
        
        if decimalIsTouched==false && whatIsTouched=="."{
            decimalIsTouched = true
            touchedDigit = whatIsTouched
        }else if decimalIsTouched==true && whatIsTouched=="."{
            touchedDigit = ""
        }else{
            touchedDigit = whatIsTouched
        }
        
        if isTypingDigit{
            display.text = displayText + touchedDigit
            display.layer.borderColor = UIColor.white.cgColor
        }else{
            display.text = touchedDigit
        }
        
        isTypingDigit = true
        
    }
    

    @IBAction func preformOperation(_ sender: UIButton) {
        decimalIsTouched = false
        
        if isTypingDigit{
            calculatorBrain.setOperand(displayValue)
            isTypingDigit = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            calculatorBrain.preformOperation(mathematicalSymbol)
        }
        
        displayValue = calculatorBrain.result
    }
    @IBOutlet weak var variable: UITextField!
    @IBOutlet weak var variableValue: UITextField!
   

    @IBAction func use(_ sender: UIButton) {
        variableValue.text! = ""
        calculatorBrain.setOperant(variable.text!)
        if let str = calculatorBrain.variableValues[variable.text!]{
            displayValue = str
        }
    }
    
    @IBAction func create(_ sender: UIButton) {
        if let temp = variable.text{
            if let db = Double(variableValue.text!){
                calculatorBrain.addVariable(variableName: temp, value: db)
            }
        }
    
    }
    @IBAction func undo(_ sender: UIButton) {
        
    }
}

