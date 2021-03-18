//
//  StatisticGraphView.swift
//  firstApp
//
//  Created by Igor Lishchenko on 2/17/19.
//  Copyright © 2019 Igor Lishchenko. All rights reserved.
//

import UIKit
import Charts
import Foundation

class StatisticGraphView: UIViewController {
    
    public static let shared = StatisticGraphView()
    
    @IBOutlet weak var avarageLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if FuelManager.shared.fuelLogs.count <= 1 {
            setChartValues()
            avarageLabel.text = "0"
        } else {
            setChartValues()
            avarageLabel.text = String(avarage())
            print(FuelManager.shared.fuelLogs.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setChartValues() {
        var numbers : [Double]
        numbers = setChart()
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        //here is the for loop
        if numbers.count == 0 {
            let value = ChartDataEntry(x: 0, y: 0)
            lineChartEntry.append(value)
        }
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
            
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: NSLocalizedString("Liters/100km", comment: "Liters/100km")) //Here we convert lineChartEntry to a LineChartDataSet
        
        line1.lineDashLengths = [5, 2.5]
        line1.highlightLineDashLengths = [10, 2.5]
        line1.drawVerticalHighlightIndicatorEnabled = false
        line1.drawHorizontalHighlightIndicatorEnabled = false
        line1.highlightColor = .yellow
        line1.setColor(.gray)
        line1.setCircleColor(.gray)
        line1.lineWidth = 2
        line1.circleRadius = 4
        line1.drawCircleHoleEnabled = false
        line1.valueFont = .boldSystemFont(ofSize: 12)
        line1.valueTextColor = NSUIColor.orange
        line1.formSize = 10
        
        let gradientColors = [ChartColorTemplates.colorFromString("#333333").cgColor,
                              ChartColorTemplates.colorFromString("#000000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        line1.drawFilledEnabled = true
    
        let data = LineChartData() //This is the object that will be added to the chart
        
        data.addDataSet(line1) //Adds the line to the dataSet
        
        let avarageLine = ChartLimitLine(limit: avarage(), label: "Avarage".localized + " \(avarage())")
        avarageLine.lineWidth = 0.8
        avarageLine.lineDashLengths = [10, 2.5]
        avarageLine.labelPosition = .leftBottom
        avarageLine.valueFont = .boldSystemFont(ofSize: 10)
        avarageLine.valueTextColor = .white
        avarageLine.lineColor = .orange
        
        
        lineChartView.data = data //finally - it adds the chart data to the chart and causes an update
        lineChartView.legend.textColor = .gray
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawLabelsEnabled = false
        
        lineChartView.rightAxis.labelTextColor = .gray
        lineChartView.rightAxis.enabled = true
        lineChartView.rightAxis.axisMaximum = 40
        lineChartView.rightAxis.axisMinimum = 0
        
        lineChartView.leftAxis.labelTextColor = .gray
        lineChartView.leftAxis.axisMaximum = 40
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.leftAxis.removeAllLimitLines()
        lineChartView.leftAxis.addLimitLine(avarageLine)
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLimitLinesBehindDataEnabled = false
        lineChartView.setScaleEnabled(false)

    }
   
    
    func setChart(arr:[Double] = [0.0]) -> [Double] {
        let i = FuelManager.shared.fuelLogs.count - 2
        var arr = [Double]()
        for b in stride(from: 0, through: i, by: 1){
            let a = Double(FuelManager.shared.fuelLogs[b].litersPerOneHundredKm)
            arr.append(a)
        }
        return arr.reversed()
    }
    
   public func avarage() -> Double{
        let arrNumber = setChart()
        let a = (arrNumber.reduce(0, +)) / Double(arrNumber.count)
        UserDefaults.standard.set(a.rounded(toPlaces: 2), forKey: "avarage")
        return a.rounded(toPlaces: 2)
    }
    
    @IBAction func Add(_ sender: UIBarButtonItem) {
        let viewController = storyboard?.instantiateViewController(withIdentifier:
            "AddLogTableViewController") as? AddLogTableViewController
        navigationController?.pushViewController(viewController!, animated: true)
        
     
    }
    
}

