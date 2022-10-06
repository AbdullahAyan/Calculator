//
//  ViewController.swift
//  Calculator
//
//  Created by Abdullah Ayan on 1.10.2022.
//

import UIKit



//
// This class only take data from ViewModel and
// adjust views.
//

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var previousOperationLabel: UILabel!
    
    var viewModel: OperationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        viewModel = OperationViewModel()
        previousOperationLabel.text = viewModel?.initialPre()
        displayLabel.text = viewModel?.initalText()
    }
    
    @IBAction func numberButtonClicked(_ sender: UIButton) {
        displayLabel.text = viewModel?.write(number: (sender.titleLabel?.text)!)
    }
    
    @IBAction func operationButtonClicked(_ sender: UIButton) {
        displayLabel.text = viewModel?.operatorClicked(symbol: (sender.titleLabel?.text)!)
        previousOperationLabel.text = viewModel?.prepreviousOutput
    }
    
    
    @IBAction func changerClicked(_ sender: UIButton) {
        displayLabel.text = viewModel?.changerClicked(symbol: (sender.titleLabel?.text)!)
    }
    
    
}

