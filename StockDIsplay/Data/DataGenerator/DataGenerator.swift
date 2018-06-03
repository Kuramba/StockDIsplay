//
//  DataGenerator.swift
//  StockDIsplay
//
//  Created by Alexei Ilin on 02/06/2018.
//  Copyright © 2018 KU. All rights reserved.
//

import UIKit

///help class to generate Data
class DataGenerator {
    
    /// Sorting Method
    class func sort(stocks:[StockAtSpecificTime], periud:StockPeriudCase) -> [StockAtSpecificTime]{
        // does not making checks for different ISIN
        
        var sortDic:[Int:[StockAtSpecificTime]] = [:]
        let periudValue = periud.value()
        
        // we group by timeInterval periods
        for stock in stocks {
            
            let group:Int = Int(stock.date.timeIntervalSinceNow/periudValue)
            
            if sortDic[group] == nil {
                sortDic[group] = []
            }
            sortDic[group]!.append(stock)
        }
        
        // there will be only 1 representor for each group
        
        var representorStockArr:[Stock] = []
        for stockGroup in sortDic {
            var midStockValue:Double = 0
            var midYieldValue:Double = 0
            
            for stock in stockGroup.value {
                if let stock = stock as? Stock {
                    midStockValue += stock.stock
                    midYieldValue += stock.yield
                }
            }
            midStockValue = midStockValue/Double(stockGroup.value.count)
            midYieldValue = midYieldValue/Double(stockGroup.value.count)
            
            var isin = ""
            if let stock = stockGroup.value[0] as? Stock {
                isin = stock.isin
            }
            
            representorStockArr.append(Stock(stock: midStockValue, yield: midYieldValue, isin: isin,
                                             date: Date(timeIntervalSinceNow: periudValue*Double(stockGroup.key))))
        }
        
        return representorStockArr.sorted { (stock1, stock2) -> Bool in
            return stock1.date > stock2.date
        }
        
    }
    
    
    
    
    
    
    ///dummy data generator
    class func generate(isinName:String) -> [StockAtSpecificTime] {
        
        var arrStocks:[StockAtSpecificTime] = []
        
        
        var startDate:Date = Date()
        var startStock:Double = 10.0
        var startYield:Double = 10.0
        
        
        for _ in 0...10000 {
            var rand:Double = (Double(arc4random_uniform(500))/100 ) * ( arc4random_uniform(1) == 1 ? 1 : -1)
            if rand + startStock < 0 { //can't be below zero
                rand = rand * -1
            }
            startStock = rand + startStock
            
            var rand2:Double = (Double(arc4random_uniform(500))/100) * ( arc4random_uniform(1) == 1 ? 1 : -1)
            if rand2 + startStock < 0 { //can't be below zero
                rand2 = rand2 * -1
            }
            startYield = rand2 + startYield
            
            startDate = startDate.addingTimeInterval(-3600) //1 hr at a time 
            
            arrStocks.append(Stock(stock: startStock, yield: startYield, isin: isinName, date: startDate))
        }
        return arrStocks
    }
}
