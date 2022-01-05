//
//  CustomMakerView.swift
//  Grounds Control
//
//  Created by Brett on 11/24/21.
//

import UIKit
import Charts

public class Coffee_Marker: MarkerView {
@IBOutlet var contentView: UIView!
@IBOutlet weak var lblnumber: UILabel!

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    private func initUI() {
        Bundle.main.loadNibNamed("Coffee_Marker", owner: self, options: nil)
                addSubview(contentView)
        
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -self.frame.size.height - 7.0
        
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        lblnumber.text = String.init(format: "%d", Int(round(entry.y)))
        layoutIfNeeded()
    }
    
}
