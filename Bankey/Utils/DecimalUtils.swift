//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Karina on 20/06/22.
//

import UIKit

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
