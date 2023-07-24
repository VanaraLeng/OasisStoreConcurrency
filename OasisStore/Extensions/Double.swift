//
//  Double.swift
//  OasisStore
//
//  Created by Vanara Leng on 6/21/23.
//

import Foundation

extension Double {
    
    /// Convert a double to a currency with 2-6 digits
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.34
    /// Convert 0.123456 to $0.12
    /// ```
    private var currencyFormatter2: NumberFormatter  {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }
    
    /// Convert a double to a currency String with 2-2 digits
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.34
    /// Convert 0.123456 to $0.12
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.0"
    }
    
    
    /// Convert a double to a currency with 2-6 digits
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter  {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 6
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }
    
    /// Convert a double to a currency String with 2-6 digits
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.0"
    }
    
    /// Convert a double to a number String with 2 digits
    /// ```
    /// Convert 12.3 to 12.30
    /// ```
    func asNumberString() -> String {
        return String(format: "%0.2f", self)
    }
    
    /// Convert a double to a percentage number String with 2 digits
    /// ```
    /// Convert 12.3456 to 12.34%
    /// ```
    func asPercentage() -> String {
        return String(format: "%0.0f", self * 100) + "%"
    }
    
    ///  Convert double to abbr number
    ///  ```
    ///  Convert 12 to 12.00
    ///  Convert 1_000 to 1.00K
    ///  Convert 1_000_000 to 1.00M
    ///  ```
    func formattedWithAbbreviations() -> String {
        let sign = self >= 0 ? "" : "-"
        switch self {
            
        case 1_000_000_000_000...:
            let number = self/1_000_000_000_000
            return "\(sign)\(number.asNumberString())Tr"
            
        case 1_000_000_000...:
            let number = self/1_000_000_000
            return "\(sign)\(number.asNumberString())Bn"
            
        case 1_000_000...:
            let number = self/1_000_000
            return "\(sign)\(number.asNumberString())Mn"
            
        case 1_000...:
            let number = self/1_000
            return "\(sign)\(number.asNumberString())K"

        default:
            return "\(sign)\(self.asNumberString())"
        }
    }
   
}
