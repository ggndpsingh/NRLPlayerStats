//
//  SafeDoubleViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 11/5/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class SafeDoubleViewController: UIViewController {
    
    @IBOutlet var inputOne: UITextField!
    @IBOutlet var inputTwo: UITextField!
    @IBOutlet var resultOutput: UILabel!
    
    var safeOne: SafeDouble {
        return SafeDouble(inputOne.text ?? "")
    }
    
    var safeTwo: SafeDouble {
        return SafeDouble(inputTwo.text ?? "")
    }
    
    var doubleOne: Double {
        return Double(inputOne.text ?? "") ?? 0
    }
    
    var doubleTwo: Double {
        return Double(inputTwo.text ?? "") ?? 0
    }
    
    @IBAction func add() {
        resultOutput.text = """
        Original: \(doubleOne + doubleTwo)
        Safe: \(safeOne + safeTwo)
        """
    }
    
    @IBAction func subtract() {
        resultOutput.text = """
        Original: \(doubleOne - doubleTwo)
        Safe: \(safeOne - safeTwo)
        """
    }
    
    @IBAction func multiply() {
        resultOutput.text = """
        Original: \(doubleOne * doubleTwo)
        Safe: \(safeOne * safeTwo)
        """
    }
}

struct SafeDouble: CustomStringConvertible {
    private(set) var original: String = ""
    private(set) var values: [Int] = []
    private(set) var decimalPlaces: Int = 0
    private(set) var isNegative: Bool = false
    
    var fraction: Int {
        return 10^^decimalPlaces
    }
    
    var negativeMultipler: Int {
        return isNegative ? -1 : 1
    }
    
    init(_ value: String) {
        original = value
        values = Array(value.replacingOccurrences(of: ".", with: "")).map { Int(String($0))! }
        isNegative = value.hasPrefix("-")
        decimalPlaces = {
            guard let decimal = Decimal(string: original) else { return 0 }
            return max(-decimal.exponent, 0)
        }()
        
        
    }
    
    init(string: String, decimalPlaces: Int) {
        guard !string.contains("."), decimalPlaces != 0 else { self.init(string); return }
        var copy = string
        copy.insert(".", at: string.index(string.endIndex, offsetBy: -decimalPlaces))
        self.init(copy)
    }
    
    var double: Double {
        return Double(original) ?? 0
    }
    
    var stringValue: String {
        return values.map { String($0) }.joined(separator: "")
    }
    
    var description: String {
        return original
    }
    
    func switchingNegative() -> SafeDouble {
        var copy = self
        copy.isNegative = !copy.isNegative
        return copy
    }
    
    static func +(_ left: SafeDouble, _ right: SafeDouble) -> SafeDouble {
        
        let (eLeft, eRight) = equilize(left, right)
        
        let reversedLeft = Array(eLeft.values.reversed())
        let reversedRight = Array(eRight.values.reversed())
        
        var resultArray: [String] = []
        var carryingForward: Bool = false
        for i in 0..<eLeft.values.count {
            var result = reversedLeft[i] + reversedRight[i]
            
            if carryingForward {
                result += 1
                carryingForward = false
            }
            
            if result > 9 {
                carryingForward = true
            }
            
            resultArray.append(String("\(result)".last!))
            if i == eLeft.values.count - 1, "\(result)".dropLast() != "" {
                resultArray.append(String("\(result)".dropLast().last!))
            }
        }
        
        let resultString = Array(resultArray.reversed()).joined(separator: "")
        let resultDecimalPlaces = max(left.decimalPlaces, right.decimalPlaces)
        
        return SafeDouble(string: resultString, decimalPlaces: resultDecimalPlaces)
    }
    
    static func -(_ left: SafeDouble, _ right: SafeDouble) -> SafeDouble {
        let (eLeft, eRight, isNegative) = swapIfNeeded(left, right)
        
        let reversedLeft = Array(eLeft.values.reversed())
        let reversedRight = Array(eRight.values.reversed())
        
        var resultArray: [String] = []
        var isBorrowing: Bool = false
        for i in 0..<eLeft.values.count {
            var top = reversedLeft[i]
            let bottom = reversedRight[i]
            
            if isBorrowing {
                top = top - 1
                isBorrowing = false
            }
            
            if top < bottom {
                isBorrowing = true
                top = Int("1\(top)")!
            }
            
            let result = top - bottom
            resultArray.append(String("\(result)".last!))
        }
        
        let resultString = Array(resultArray.reversed()).joined(separator: "")
        let resultDecimalPlaces = max(left.decimalPlaces, right.decimalPlaces)
        
        var safe = SafeDouble(string: resultString, decimalPlaces: resultDecimalPlaces)
        safe.isNegative = isNegative
        return safe
    }
    
    static func *(_ first: SafeDouble, _ second: SafeDouble) -> SafeDouble {
        var leftCharacterArray  = first.stringValue.reversed().map { Int(String($0))! }
        var rightCharacterArray = second.stringValue.reversed().map { Int(String($0))! }
        var result = [Int](repeating: 0, count: leftCharacterArray.count + rightCharacterArray.count)
        
        for leftIndex in 0..<leftCharacterArray.count {
            for rightIndex in 0..<rightCharacterArray.count {
                
                let resultIndex = leftIndex + rightIndex
                
                result[resultIndex] = leftCharacterArray[leftIndex] * rightCharacterArray[rightIndex] + (resultIndex >= result.count ? 0 : result[resultIndex])
                if result[resultIndex] > 9 {
                    result[resultIndex + 1] = (result[resultIndex] / 10) + (resultIndex+1 >= result.count ? 0 : result[resultIndex + 1])
                    result[resultIndex] -= (result[resultIndex] / 10) * 10
                }
                
            }
            
        }
        
        result = Array(result.reversed())
        let resultString = result.map { String($0) }.joined(separator: "")
        let decimalPlaces = first.decimalPlaces + second.decimalPlaces
        
        return SafeDouble(string: resultString, decimalPlaces: decimalPlaces)
    }
    
    static func swapIfNeeded(_ left: SafeDouble, _ right: SafeDouble) -> (SafeDouble, SafeDouble, Bool) {
        var shouldSwap = false
        
        let (eLeft, eRight) = equilize(left, right)
        
        for i in 0..<eLeft.values.count {
            let l = eLeft.values[i]
            let r = eRight.values[i]
            if i == 0 {
                if l < r {
                    shouldSwap = true; break
                }
            } else {
                let lastL = eLeft.values[i-1]
                let lastR = eRight.values[i-1]
                if lastL == lastR && l < r {
                    shouldSwap = true; break
                }
            }
        }
        
        return shouldSwap ? (eRight, eLeft, shouldSwap) : (eLeft, eRight, shouldSwap)
    }
    
    static func equilize(_ left: SafeDouble, _ right: SafeDouble) -> (SafeDouble, SafeDouble) {
        let decimalDifference: Int = abs(left.decimalPlaces - right.decimalPlaces)
        
        var eLeft = left
        var eRight = right
        
        for _ in 0..<decimalDifference {
            if left.decimalPlaces > right.decimalPlaces {
                eRight.values.append(0)
            } else {
                eLeft.values.append(0)
            }
        }

        guard eLeft.values.count != eRight.values.count else { return (eLeft, eRight) }
        let difference = abs(eLeft.values.count - eRight.values.count)
        let isLeftSmaller = eLeft.values.count < eRight.values.count
        var smaller = isLeftSmaller ? eLeft : eRight
        
        for _ in 0..<difference {
            smaller.values.insert(0, at: 0)
        }
        
        return isLeftSmaller ? (smaller, eRight) : (eLeft, smaller)
    }
}

extension String {
    var truncatingZeros: String {
        guard let trailing = last else { return self }
        switch trailing {
        case ".":
            return String(dropLast())
        case "0":
            return String(dropLast()).truncatingZeros
        default:
            return self
        }
    }
    
    var addingLeadingZero: String {
        guard hasPrefix(".") else { return self }
        return "0" + self
    }
    
    var addingTrailingZero: String {
        guard hasSuffix(".") else { return self }
        return self + "0"
    }
    
    func addingNegativeSign(isNegative: Bool) -> String {
        guard isNegative && !self.hasPrefix("-") else { return self }
        return "-" + self
    }
}

infix operator ^^
func ^^(radix: Int, power: Int) -> Int {
    guard power > 0 else { return 1 }
    var result = radix
    for _ in 1..<power {
        result = result * radix
    }
    return result
}
