//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billInString = ""

    @IBAction func tipChanged(_ sender: UIButton) {
        //Deselect all tip buttons via IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
        
        //dismiss the keyboard after user type in the amount
        //billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        numberOfPeople = Int(sender.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
//        print(tip)
//        print(numberOfPeople)
//        print(billTextField.text!)
        let totalBill = Double(billTextField.text ?? "0.0")
        let billPlusTip = totalBill! * (1 + tip)
        let billPerPerson = billPlusTip / Double(numberOfPeople)
        billInString = String(format: "%.2f", billPerPerson)
        
        //transition to the result page
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bill = billInString
            destinationVC.numberOfPeople = numberOfPeople
            destinationVC.tipPercentage = Int(tip * 100)
            
        }
    }
}

