//
//  Stock.swift
//  StockDIsplay
//
//  Created by Alexei Ilin on 02/06/2018.
//  Copyright © 2018 KU. All rights reserved.
//

import Foundation

struct Stock: StockAtSpecificTime {
    var stock:Double
    var yield:Double
    var isin:String
 
    // StockAtSpecificTime
    var date:Date
}
