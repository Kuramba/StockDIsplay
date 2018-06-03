//
//  Stock.swift
//  StockDIsplay
//
//  Created by Alexei Ilin on 02/06/2018.
//  Copyright © 2018 KU. All rights reserved.
//

import Foundation
import Charts

protocol StockAtSpecificTime {
    var date:Date {get set}
    func displayDate(periud:StockPeriudCase) -> Double
    func displayLabel(periud:StockPeriudCase) -> String
}


extension StockAtSpecificTime {
    
    func displayDate(periud:StockPeriudCase) -> Double {
        switch periud {
        case .hour: return displayDate(formatBig: "hh", formaSmall: "mm")
        case .oneWeek: return displayDate(formatBig: "MM", formaSmall: "dd")
        case .oneMonth: return displayDate(formatBig: "MM", formaSmall: "dd")
        case .threeMonth: return displayDate(formatBig: "MM", formaSmall: "dd")
        case .sixMonth: return displayDate(formatBig: "MM", formaSmall: "dd")
        case .oneYear: return displayDate(formatBig: "yy", formaSmall: "MM")
        case .threeYears: return displayDate(formatBig: "yy", formaSmall: "MM")
        }
    }
    
    // in our case we only need to display date as float
    // if we would need something stringy, I would extend the Chart framework
    private func displayDate(formatBig:String, formaSmall:String, isApplyPercentDisplay:Bool = false ) -> Double {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatBig
        let big = dateFormatter.string(from: date)
        dateFormatter.dateFormat = formaSmall
        let small = dateFormatter.string(from: date)
        
        if isApplyPercentDisplay {
            return (((Double(big) ?? 0)/60)*100) + (Double(small) ?? 0)/60
        }else {
            return (Double(big) ?? 0)+((Double(small) ?? 0)/100)
        }
    }
    
    func displayLabel(periud:StockPeriudCase) -> String {
        switch periud {
        case .hour: return displayLabel(format: "hh:mm")
        case .oneWeek: return displayLabel(format: "d MMM")
        case .oneMonth: return displayLabel(format: "MMM")
        case .threeMonth: return displayLabel(format: "MMM")
        case .sixMonth: return displayLabel(format: "MMM yy")
        case .oneYear: return displayLabel(format: "MMM yy")
        case .threeYears: return displayLabel(format: "MMM yy")
        }
    }
    func displayLabel(format:String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}
