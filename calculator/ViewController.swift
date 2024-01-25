//
//  ViewController.swift
//  calculator
//
//  Created by Егор Дмитриев on 10.01.2024.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resultDisplayLabel: UILabel!
    
    
    var stilltyping = false
    var firstOper: Double = 0
    var secondOper: Double = 0
    var operationSing: String = ""
    var dotPlaced = false
    
    var currInput: Double {
        get {
            Double(resultDisplayLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArr = value.components(separatedBy: ".")
            if valueArr[1] == "0"{
                resultDisplayLabel.text = "\(valueArr[0])"
            } else {
                resultDisplayLabel.text = "\(newValue)"
            }
            stilltyping = false
        }
    }
    
    @IBAction func numPress(_ sender: UIButton) {
        let num = sender.currentTitle!
        
        if stilltyping {
            resultDisplayLabel.text = resultDisplayLabel.text! + num
        } else {
            resultDisplayLabel.text = num
            stilltyping = true
        }
    }
    
    @IBAction func twoOperandsPress(_ sender: UIButton) {
        operationSing = sender.currentTitle!
        firstOper = currInput
        //print(firstOper)
        stilltyping = false
        dotPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currInput = operation(firstOper, secondOper)
        stilltyping = false
    }
    @IBAction func equalPress(_ sender: UIButton) {
        if stilltyping {
            secondOper = currInput
        }
        
        dotPlaced = false
        
        switch operationSing {
        
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        default: break
        }
    }
    
    @IBAction func clearPress(_ sender: UIButton) {
        firstOper = 0
        secondOper = 0
        currInput = 0
        resultDisplayLabel.text = "0"
        operationSing = ""
        stilltyping = false
        dotPlaced = false
    }
    
    @IBAction func plusMinusPress(_ sender: UIButton) {
        currInput = -currInput
    }
    
    @IBAction func percentPress(_ sender: UIButton) {
        if firstOper == 0 {
            currInput = currInput / 100
        } else {
            secondOper = firstOper * currInput / 100
        }
        stilltyping = false
    }
    
    @IBAction func sqrtPress(_ sender: UIButton) {
        currInput = sqrt(currInput)
    }
    
    @IBAction func dotPress(_ sender: UIButton) {
        if stilltyping && !dotPlaced{
            resultDisplayLabel.text = resultDisplayLabel.text! + "."
            dotPlaced = true
        } else if !stilltyping && !dotPlaced {
            resultDisplayLabel.text = "0."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

