//
//  PickISINViewController.swift
//  StockDIsplay
//
//  Created by Alexei Ilin on 03/06/2018.
//  Copyright © 2018 KU. All rights reserved.
//

import UIKit

class PickISINViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    let dataSource:[(corp:String,isin:String)] = [(corp:"Microsoft Corp.", isin:"US5949181045"),
                                      (corp:"Google Inc.", isin:"US38259P5089"),
                                      (corp:"Apple Inc.", isin:"US0378331005"),
                                      (corp:"Bear Zertifikat auf DAX", isin:"NL0000729408"),
                                      (corp:"Yusen Logistics Co.", isin:"JP3946600008"),
                                      (corp:"Aktienanleihe auf BASF", isin:"DE000DZ21632"),
                                      (corp:"BMW Australia", isin:"CH0031240127")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.reloadData()
    }

}
extension PickISINViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "PickISINTableViewCell", for: indexPath) as! PickISINTableViewCell
        cell.selectionStyle = .none
        cell.corpName.text = dataSource[indexPath.row].corp
        cell.isinName.text = dataSource[indexPath.row].isin
        cell.isinName.textColor = .gray
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ChartDisplayViewController") as? ChartDisplayViewController {
            vc.baseDataSet = DataGenerator.generate(isinName: dataSource[indexPath.row].isin)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
