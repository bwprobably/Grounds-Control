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
    
    let titles = ["Sweet", "Floral", "Fruit", "Nut", "Spice", "Roasted", "Choco" , "Veggie" , "Other"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
}

class XAxis_Bad_Formatter: AxisValueFormatter {
    
    let titles = ["Aged", "Decomp", "Mold", "Overroast", "Tainted", "Underripe", "Overripe", "Underroast"]
    
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
    
    
    //MARK: Added value selection -> make popup or icon to show value to user
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        numberLabel.text = String.init(format: "%d", Int(round(entry.y)))
    }
    
    //MARK: Add in calculation to outline weather or not the coffee has a specific "flavor" profile?
    //var firstLoad = true
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items: Coffee!
    
    
    
    @IBOutlet weak var positive_Chart: RadarChartView!
    @IBOutlet weak var negative_Chart: RadarChartView!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    
    //First load with pulling info from core data
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
        
//        if(firstLoad)
//        {
//            firstLoad = false
//            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Grounds_Control")
//            do {
//                let results:NSArray = try context.fetch(request) as NSArray
//                for result in results
//                {
                    //let items = result as! Coffee
                    
                    
                    
                    func setData(){
                    
                     // puts data from CD into array for labels
                    let positiveDataSet = RadarChartDataSet(
                    entries: [
                        RadarChartDataEntry(value:Double (items?.sweet ?? 1)),
                        RadarChartDataEntry(value:Double (items?.floral ?? 1)),
                        RadarChartDataEntry(value:Double (items?.fruity ?? 1)),
                        RadarChartDataEntry(value:Double (items?.nutty ?? 1)),
                        RadarChartDataEntry(value:Double (items?.spice ?? 1)),
                        RadarChartDataEntry(value:Double (items?.roasted ?? 1)),
                        RadarChartDataEntry(value:Double (items?.chocolate ?? 1)),
                        RadarChartDataEntry(value:Double (items?.veggie ?? 1)),
                        RadarChartDataEntry(value:Double (items?.other ?? 1))
                    ]
                )
                        
                    let badDataSet = RadarChartDataSet(
                        entries: [
                            //["Aged", "Decomp", "Mold", "Over Roast", "Tainted", "Under Ripe", "Over Ripe", "Under Roast"]
                            RadarChartDataEntry(value:Double (items?.aged ?? 1)),
                            RadarChartDataEntry(value:Double (items?.decomp ?? 1)),
                            RadarChartDataEntry(value:Double (items?.mold ?? 1)),
                            RadarChartDataEntry(value:Double (items?.overroast ?? 1)),
                            RadarChartDataEntry(value:Double (items?.tainted ?? 1)),
                            RadarChartDataEntry(value:Double (items?.underripe ?? 1)),
                            RadarChartDataEntry(value:Double (items?.overroast ?? 1)),
                            RadarChartDataEntry(value:Double (items?.underroast ?? 1))
                            
                        ]
                        )
                        // 2
                        let positive_Data = RadarChartData(dataSets: [positiveDataSet])
                        let negative_Data = RadarChartData(dataSets: [badDataSet])

                        // 3
                        positive_Chart.data = positive_Data
                        negative_Chart.data = negative_Data
                        
                        positiveDataSet.lineWidth = 1.5
                        badDataSet.lineWidth = 1.5

                        // 2
                        
                        let redColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 1)
                        let redFillColor = UIColor(red: 247/255, green: 67/255, blue: 115/255, alpha: 0.6)
                        positiveDataSet.colors = [redColor]
                        positiveDataSet.fillColor = redFillColor
                        positiveDataSet.drawFilledEnabled = true
                        positiveDataSet.drawHighlightCircleEnabled = true
                        positiveDataSet.setDrawHighlightIndicators(false)
                        
                        let blueColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
                        let blueFillColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 0.6)
                        badDataSet.colors = [blueColor]
                        badDataSet.fillColor = blueFillColor
                        badDataSet.drawFilledEnabled = true
                        badDataSet.drawHighlightCircleEnabled = true
                        badDataSet.setDrawHighlightIndicators(false)
                        
                            
                        // 3
                        positiveDataSet.valueFormatter = DataSetValueFormatter()
                        badDataSet.valueFormatter = DataSetValueFormatter()
                        
                        let xAxis = positive_Chart.xAxis
                        xAxis.labelTextColor = UIColor.label
                        xAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                        xAxis.valueFormatter = XAxisFormatter()
                        
                        
                        
                        let BadxAxis = negative_Chart.xAxis
                        BadxAxis.labelTextColor = UIColor.label
                        BadxAxis.labelFont = .systemFont(ofSize: 11, weight: .semibold)
                        BadxAxis.valueFormatter = XAxis_Bad_Formatter()
                        
                        
                        let yAxis = positive_Chart.yAxis
                        yAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                        yAxis.labelTextColor = UIColor.label
                        print(positiveDataSet.entries)
                        //yAxis.resetCustomAxisMax()
//                        yAxis.resetCustomAxisMin()
                        yAxis.labelCount = 5
                        yAxis.drawTopYLabelEntryEnabled = false
                        yAxis.axisMaximum = 5
                        yAxis.axisMinimum = 0
                        yAxis.valueFormatter = YAxisFormatter()
                        
                        let BadyAxis = negative_Chart.yAxis
                        BadyAxis.labelFont = .systemFont(ofSize: 12, weight: .semibold)
                        print(badDataSet.entries)
                        BadyAxis.labelTextColor = UIColor.label
                        BadyAxis.labelCount = 4
                        BadyAxis.drawTopYLabelEntryEnabled = false
                        BadyAxis.axisMaximum = 4
                        BadyAxis.axisMinimum = 0
                        BadyAxis.valueFormatter = YAxisFormatter()
                        
                        
                        
                    }

                        
                        positive_Chart!.delegate = self
                        negative_Chart!.delegate = self
                        setData()
        
                        //positive chart attributes
                        positive_Chart.rotationEnabled = true
                        positive_Chart.legend.enabled = false
                        positive_Chart.notifyDataSetChanged()
                        positive_Chart.innerWebLineWidth = 1.5
                        positive_Chart.innerWebColor = UIColor.label
                        positive_Chart.webColor = UIColor.label
                        positive_Chart.sizeToFit()
                        positive_Chart.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
        
        
                    
                        //negative chart attributes
                        negative_Chart.rotationEnabled = true
                        negative_Chart.legend.enabled = false
                        negative_Chart.notifyDataSetChanged()
                        negative_Chart.innerWebLineWidth = 1.5
                        negative_Chart.innerWebColor = UIColor.label
                        negative_Chart.webColor = UIColor.label
                        negative_Chart.sizeToFit()
                        negative_Chart.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
                    
                    
                    //javaList.append(drink)
                }
//            } catch
//            {
//                print("fetch failed")
//            }
//        }
//
//
    }

