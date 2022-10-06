//
//  OperationViewModel.swift
//  Calculator
//
//  Created by Abdullah Ayan on 2.10.2022.
//

import Foundation

//
// ViewModel can reach model and update.
//

class OperationViewModel {
    var model = OperationModel()
    var operationElemets = [Double]()
    var previousOutput = "0"
    var prepreviousOutput = "0" {
        didSet {
            OperationModel.sharedPre = prepreviousOutput
        }
    }
    var previousSymbol = ""
    var nextSembol = ""
    var onWriting = "" {
        didSet {
            OperationModel.sharedText = onWriting
        }
    }
//
//    This function takes input from user and sets necessary places.
//
    func write(number : String) -> String {
        if onWriting == "0" {
            onWriting = number
        }else if number == ","{
            onWriting += "."
        }else {
            onWriting += number
        }
        return onWriting
    }
    
//
//    When user press operator buttons, this function calculate the output.
//
    
    func operatorClicked(symbol: String) -> String {
        if symbol != "=" {
            nextSembol = symbol
        }
        operationElemets.append(Double(onWriting) ?? 0)
        onWriting = "0"
        
        if operationElemets.count == 2 {
            switch previousSymbol {
            case "+":
                model.output = (operationElemets.removeLast() + operationElemets.removeLast())
                operationElemets.append(model.output)
                setPres()
                previousSymbol = nextSembol
            case "×":
                model.output = (operationElemets.removeLast() * operationElemets.removeLast())
                operationElemets.append(model.output)
                setPres()
                previousSymbol = nextSembol
            case "-":
                let second = operationElemets.removeLast()
                let first = operationElemets.removeFirst()
                model.output = first - second
                operationElemets.append(model.output)
                setPres()
                previousSymbol = nextSembol
            case "÷":
                let second = operationElemets.removeLast()
                let first = operationElemets.removeFirst()
                model.output = first / second
                operationElemets.append(model.output)
                setPres()
                previousSymbol = nextSembol
            case "=":
                break
            default:
                model.output = 0
                setPres()
            }
        }else {
            previousSymbol = symbol
        }
//
//      Tries to convert output to Integer for beauty purposes
//
        if let int = Int(exactly: operationElemets[0] ) {
            return String(int)
        }else {
            return String(operationElemets[0])
        }
    }
    
//
//  Adjust previousOutputLabel in ViewController
//
    
    func setPres() {
        prepreviousOutput = previousOutput
        previousOutput = String(model.output)
    }
    
    func changerClicked(symbol: String) -> String {
        switch symbol {
        case "AC":
            onWriting = "0"
            operationElemets = [Double]()
        case "+/-":
            if onWriting.contains("-") {
                onWriting.removeFirst(1)
            } else {
                onWriting = "-" + onWriting
            }
        case "%":
            onWriting = String((Double(onWriting) ?? 0) / 100)
        case "π":
            onWriting = String(Double.pi)
        case "log2":
            onWriting = String(log2((Double(onWriting) ?? 0)))
        case "√x":
            onWriting = String(sqrt(Double(onWriting) ?? 0))
        case "x²":
            onWriting = String(pow((Double(onWriting) ?? 0),2))
        case "x!":
            let donWriting = Double(onWriting) ?? 0
            var output = 1
            
            if (donWriting > 1) {
                for j in 1...Int(donWriting){
                    output *= j
                }
            }
            onWriting = "0"
            return String(output)
            
        default:
            onWriting = "0"
        }
        
        if let int = Int(exactly: Double(onWriting)! ) {
            onWriting = "0"
            return String(int)
        }else {
            var temp = Double(onWriting)!
            onWriting = "0"
            return String(temp)
        }
    }
//
//  This three functions important because when UIDevice.oriantation change controllers needs to update label text.
//
    func initalText() -> String {
        return OperationModel.sharedText
    }
    
    func initialPre() -> String {
        return OperationModel.sharedPre
    }
    
    func previousCalculation() -> String{
        return OperationModel.sharedText
    }
    
}
