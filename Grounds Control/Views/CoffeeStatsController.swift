import Foundation
import UIKit
import CoreData
import Charts



class DataSetValueFormatter: ValueFormatter {
    

    
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}

//formatter foro the "xaxis" of radar graph.
class XAxisFormatter: AxisValueFormatter//IAxisValueFormatter
{
    
    let titles = ["Sweet", "Floral", "Fruit", "Nut", "Spice", "Roasted", "Coco" , "Veggie" , "Other"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
}

class XAxis_Bad_Formatter: AxisValueFormatter {
    
    let titles = ["Aged", "Decomp", "Mold", "Over Roast", "Tainted", "Under Ripe", "Over Ripe", "Under Roast"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
    
}


//formatter class for the "yaxis" of radar graph.
class YAxisFormatter: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        "\(Int(value))"
    }
}


class CoffeeStatsView: UIViewController ,ChartViewDelegate {

    static let identifier = "CoffeeStatsView"
    
    var firstLoad = true
    
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items:[Coffee]!
    
    
    
    @IBOutlet weak var radarChart: RadarChartView!
    @IBOutlet weak var negative_Chart: RadarChartView!
    
    //First load with pulling info from core data
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Grounds_Control")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let covfefe = result as! Coffee
                    
                    
                    
                    func setData(){
                    
                     // puts data from CD into array for labels
                    let redDataSet = RadarChartDataSet(
                    entries: [
                        RadarChartDataEntry(value:Double (covfefe.sweet)),
                        RadarChartDataEntry(value:Double (covfefe.floral)),
                        RadarChartDataEntry(value:Double (covfefe.fruity)),
                        RadarChartDataEntry(value:Double (covfefe.nutty)),
                        RadarChartDataEntry(value:Double (covfefe.spice)),
                        RadarChartDataEntry(value:Double (covfefe.roasted)),
                        RadarChartDataEntry(value:Double (covfefe.sour)),
                        RadarChartDataEntry(value:Double (covfefe.veggie)),
                        RadarChartDataEntry(value:Double (covfefe.other))
                    ]
                )
                        
                    let badDataSet = RadarChartDataSet(
                        entries: [
                            //["Aged", "Decomp", "Mold", "Over Roast", "Tainted", "Under Ripe", "Over Ripe", "Under Roast"]
                            RadarChartDataEntry(value:Double (covfefe.aged)),
                            RadarChartDataEntry(value:Double (covfefe.decomp)),
                            RadarChartDataEntry(value:Double (covfefe.mold)),
                            RadarChartDataEntry(value:Double (covfefe.overroast)),
                            RadarChartDataEntry(value:Double (covfefe.tainted)),
                            RadarChartDataEntry(value:Double (covfefe.underripe)),
                            RadarChartDataEntry(value:Double (covfefe.overroast)),
                            RadarChartDataEntry(value:Double (covfefe.underroast))
                            
                        ]
                        )
                        // 2
                        let data = RadarChartData(dataSets: [redDataSet])
                        let negative_Data = RadarChartData(dataSets: [badDataSet])

                        // 3
                        radarChart.data = data
                        negative_Chart.data = negative_Data
                        
                        redDataSet.lineWidth = 1.5
                        badDataSet.lineWidth = 1.5

                        // 2
                        
                        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
                        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 0.6)
                        redDataSet.colors = [redColor]
                        redDataSet.fillColor = redFillColor
                        redDataSet.drawFilledEnabled = true
                        redDataSet.drawHighlightCircleEnabled = true
                        redDataSet.setDrawHighlightIndicators(false)
                        
                        let blueColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
                        let blueFillColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 0.6)
                        badDataSet.colors = [blueColor]
                        badDataSet.fillColor = blueFillColor
                        badDataSet.drawFilledEnabled = true
                        badDataSet.drawHighlightCircleEnabled = true
                        badDataSet.setDrawHighlightIndicators(false)
                        
                            
                        // 3
                        redDataSet.valueFormatter = DataSetValueFormatter()
                        badDataSet.valueFormatter = DataSetValueFormatter()
                        
                       let xAxis = radarChart.xAxis
                        xAxis.labelTextColor = UIColor.label
                        xAxis.wordWrapEnabled = true
                        xAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                        xAxis.xOffset = 0
                        xAxis.yOffset = 0
                        xAxis.valueFormatter = XAxisFormatter()
                        
                        let BadxAxis = negative_Chart.xAxis
                        BadxAxis.labelTextColor = UIColor.label
                         BadxAxis.wordWrapEnabled = true
                         BadxAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                         BadxAxis.xOffset = 0
                         BadxAxis.yOffset = 0
                         BadxAxis.valueFormatter = XAxis_Bad_Formatter()
                        
                        
                        let yAxis = radarChart.yAxis
                        yAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                        yAxis.labelTextColor = UIColor.label
                        yAxis.labelCount = 5
                        yAxis.drawTopYLabelEntryEnabled = true
                        yAxis.axisMaximum = 4
                        yAxis.axisMinimum = 0
                        yAxis.valueFormatter = YAxisFormatter()
                        
                        let BadyAxis = negative_Chart.yAxis
                        BadyAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                        BadyAxis.labelTextColor = UIColor.label
                        BadyAxis.labelCount = 5
                        BadyAxis.drawTopYLabelEntryEnabled = true
                        BadyAxis.axisMaximum = 4
                        BadyAxis.axisMinimum = 0
                        BadyAxis.valueFormatter = YAxisFormatter()
                        
                    }

                        
                        radarChart!.delegate = self
                        negative_Chart!.delegate = self
                        setData()
                        radarChart.rotationEnabled = true
                        radarChart.legend.enabled = false
                        radarChart.notifyDataSetChanged()
                        radarChart.innerWebLineWidth = 1.5
                        radarChart.innerWebColor = UIColor.label
                        radarChart.webColor = UIColor.label
                        radarChart.sizeToFit()
                        radarChart.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
                    
                        
                        negative_Chart.rotationEnabled = true
                        negative_Chart.legend.enabled = false
                        negative_Chart.notifyDataSetChanged()
                        negative_Chart.innerWebLineWidth = 1.5
                        negative_Chart.innerWebColor = UIColor.label
                        negative_Chart.webColor = UIColor.label
                    
                        negative_Chart.sizeToFit()
                        negative_Chart.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
                    
                    
                    print(covfefe)
                    //javaList.append(drink)
                }
            } catch
            {
                print("fetch failed")
            }
        }
  
        
    }
    
    
    
}
