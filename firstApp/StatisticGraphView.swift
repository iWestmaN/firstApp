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

class StatisticGraphView: UITableViewController {
    
    public static let shared = StatisticGraphView()
    
    @IBOutlet weak var avarageLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setChartValues()
        avarageLabel.text = String(avarage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setChartValues() {
        
        var numbers : [Double] = setChart()
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        //here is the for loop
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Liters per 100 km") //Here we convert lineChartEntry to a LineChartDataSet
        
        line1.lineDashLengths = [5, 2.5]
        line1.highlightLineDashLengths = [10, 2.5]
        line1.highlightColor = .yellow
        line1.setColor(.orange)
        line1.setCircleColor(.gray)
        line1.lineWidth = 2
        line1.circleRadius = 4
        line1.drawCircleHoleEnabled = false
        line1.valueFont = .boldSystemFont(ofSize: 14)
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
        
        lineChartView.data = data //finally - it adds the chart data to the chart and causes an update
        lineChartView.legend.textColor = .gray
        lineChartView.rightAxis.labelTextColor = .gray
        lineChartView.leftAxis.labelTextColor = .gray
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawLabelsEnabled = false
    }
    
    func setChart() -> [Double] {
        var i = FuelManager.shared.fuelLogs.count
        i -= 1
        // print(i)
        var arr = [Double]()
        for b in stride(from: 0, through: i, by: 1){
            let a = Double(FuelManager.shared.fuelLogs[b].litersPerOneHundredKm)
            arr.append(a)
            //    print(arr)
        }
        return arr.reversed()
    }
    func avarage() -> Double{
        let arrNumber = setChart()
        let a = (arrNumber.reduce(0, +)) / Double(arrNumber.count)
        //   print(a)
        return a.rounded(toPlaces: 2)
    }
    
    
}

