//
//  StockPeriudCase.swift
//  StockDIsplay
//
//  Created by Alexei Ilin on 03/06/2018.
//  Copyright © 2018 KU. All rights reserved.
//

import Foundation

enum StockPeriudCase {
    case hour
    case oneWeek
    case oneMonth
    case threeMonth
    case sixMonth
    case oneYear
    case threeYears
    
    func value() -> TimeInterval {
        switch self {
        case .hour: return (60*60)
        case .oneWeek: return (60 * 60 * 24 * 7)
        case .oneMonth: return (60 * 60 * 24 * 30.4)
        case .threeMonth: return (60 * 60 * 24 * 91.2)
        case .sixMonth: return (60 * 60 * 24 * 182.5)
        case .oneYear: return (60 * 60 * 24 * 365)
        case .threeYears: return (60 * 60 * 24 * 365 * 3)
        }
    }
}
