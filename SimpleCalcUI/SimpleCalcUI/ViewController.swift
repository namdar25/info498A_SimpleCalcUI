//
//  ViewController.swift
//  SimpleCalcUI
//
//  Created by Shawn Namdar on 10/22/15.
//  Copyright © 2015 Shawn Namdar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorTextView: UITextView!
    @IBOutlet weak var enterButton: UIButton!

    var currentCalculatorType: CalculatorType = CalculatorType.Standard
    
    @IBAction func touchNumber(sender: UIButton) {
        if okToAddNumber(calculatorTextView.text!, calculatorType: currentCalculatorType) {
            let newString = calculatorTextView.text! + sender.titleLabel!.text!
            calculatorTextView.text! = newString
        }
    }
    
    @IBAction func touchFunction(sender: UIButton) {
        switch currentCalculatorType{
        case .RPN:
            if okToAddFunction(calculatorTextView.text!, functionToCheck:sender.titleLabel!.text!, calculatorType: currentCalculatorType) {
            calculatorTextView.text = solve("\(calculatorTextView.text!)" + " " + "\(sender.titleLabel!.text!)", calculatorType: currentCalculatorType)
            }
        case .Standard:
            if okToAddFunction(calculatorTextView.text!, functionToCheck:sender.titleLabel!.text!, calculatorType: currentCalculatorType) {
                let newString = calculatorTextView.text! + " " + sender.titleLabel!.text! + " "
                calculatorTextView.text! = newString
            }
        }
    }

    
    @IBAction func touchOperator(sender: UIButton) {
        switch currentCalculatorType{
        case .RPN:
            if okToAddOperator(calculatorTextView.text!, operatorToCheck:sender.titleLabel!.text!, calculatorType: currentCalculatorType) {
            calculatorTextView.text = solve("\(calculatorTextView.text!)" + " " + "\(sender.titleLabel!.text!)", calculatorType: currentCalculatorType)
            }
        case .Standard:
            if okToAddOperator(calculatorTextView.text!, operatorToCheck:sender.titleLabel!.text!, calculatorType: currentCalculatorType) {
                let newString = calculatorTextView.text! + " " + sender.titleLabel!.text! + " "
                calculatorTextView.text! = newString
            }
            
        }
    }
    @IBAction func touchEnter(sender: UIButton) {
        switch currentCalculatorType{
        case .RPN:
            calculatorTextView.text = calculatorTextView.text + " "
        case .Standard:
            calculatorTextView.text = solve(calculatorTextView.text!, calculatorType: currentCalculatorType)
        }
    }
    @IBAction func touchClear(sender: AnyObject) {
        calculatorTextView.text = ""
    }
    
    
    @IBAction func segmentControlValueChange(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentCalculatorType = CalculatorType.Standard
            enterButton.titleLabel!.font = enterButton.titleLabel!.font.fontWithSize(30)
            enterButton.setTitle("=", forState: UIControlState.Normal)
        } else {
            currentCalculatorType = CalculatorType.RPN
            enterButton.titleLabel!.font = enterButton.titleLabel!.font.fontWithSize(20)
            enterButton.setTitle("Enter", forState: UIControlState.Normal)
        }
    }

        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

