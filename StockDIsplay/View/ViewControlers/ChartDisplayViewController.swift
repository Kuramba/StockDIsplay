//
//  ViewController.swift
//  StockDIsplay
//
//  Created by Alexei Ilin on 02/06/2018.
//  Copyright © 2018 KU. All rights reserved.
//

import UIKit
import Charts

class ChartDisplayViewController: UIViewController {
    
    @IBOutlet weak var chart: LineChartView!
    
    // default configuration
    var displayCase:StockDisplayCase = .stock
    var periudCase:StockPeriudCase = .oneWeek
    var baseDataSet:[StockAtSpecificTime] = []
    
    @IBOutlet var periodButtons: [UIButton]!
    @IBOutlet weak var periudButtonDefault: UIButton! //1 week button
    @IBOutlet weak var switchCaseButton: UIButton!
    
    
    
    @IBAction func time1WButtonClicked(_ sender: UIButton) {
        setPeriudUI(periud: .oneWeek, sender: sender)
    }
    @IBAction func time1MButtonClicked(_ sender: UIButton) {
        setPeriudUI(periud: .oneMonth, sender: sender)
    }
    @IBAction func time3MButtonClicked(_ sender: UIButton) {
        setPeriudUI(periud: .threeMonth, sender: sender)
    }
    @IBAction func time6MButtonClicked(_ sender: UIButton) {
        setPeriudUI(periud: .sixMonth, sender: sender)
    }
    @IBAction func time1yButtonClicked(_ sender: UIButton) {
        setPeriudUI(periud: .oneYear, sender: sender)
    }
    @IBAction func time3yButtonClicked(_ sender: UIButton) {
        setPeriudUI(periud: .threeYears, sender: sender)
    }
    
    @IBAction func yieldStockSwitch(_ sender: Any) {
        if displayCase == .stock {
            displayCase = .yield
            switchCaseButton.setTitle("Yield", for: .normal)
        }else {
            displayCase = .stock
            switchCaseButton.setTitle("Stock", for: .normal)
        }
        
        reloadChartDataUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartDesign()
        time1WButtonClicked(periudButtonDefault)
    }
    
    func setPeriudUI(periud:StockPeriudCase, sender:UIButton) {
        
        for button in periodButtons {
            button.backgroundColor = .clear
        }
        sender.backgroundColor = .green
        sender.layer.cornerRadius = 8
        
        periudCase = periud
        reloadChartDataUI()
    }
    
    

    // MARK: - Private
    
    private func reloadChartDataUI() {

        let arrReprsentators = DataGenerator.sort(stocks: baseDataSet, periud: periudCase)
        
        var dataEntries:[ChartDataEntry] = []
        var increment:Double = 0
        for stock in arrReprsentators {
            increment += 1
            let dataEntry = ChartDataEntry(x: increment,
                                           y: displayCase == .stock ? (stock as! Stock).stock : (stock as! Stock).yield )
            dataEntries.append(dataEntry)
            
        }
        var label:String = ""
        if dataEntries.count > 0 , let randomStock = arrReprsentators[0] as? Stock {
            label = randomStock.isin
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: label)
        
        let chartData = LineChartData(dataSets: [chartDataSet])
        chart.data = chartData
    }
    
    private func setChartDesign() {

        chart.xAxis.labelCount = 0
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.drawGridLinesEnabled = true
        chart.xAxis.avoidFirstLastClippingEnabled = true

        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        
        chart.leftAxis.drawAxisLineEnabled = true
        chart.leftAxis.drawAxisLineEnabled = true
        chart.pinchZoomEnabled = true
        chart.doubleTapToZoomEnabled = true
        chart.legend.enabled = true
        chart.chartDescription?.text = " "
    }
}
