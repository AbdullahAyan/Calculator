//
//  OperationModel.swift
//  Calculator
//
//  Created by Abdullah Ayan on 2.10.2022.
//

import Foundation

//
// Casual custom data type - ViewModel have access
//

class OperationModel {
    static var sharedText = "0"
    static var sharedPre = "0"
    var output: Double = 0 {
        didSet {
            OperationModel.sharedText = String(output)
        }
    }
}
