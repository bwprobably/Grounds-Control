//
//  CoffeeListTableViewCell.swift
//  Grounds Control
//
//  Created by Brett on 10/21/21.
//
import UIKit

class CoffeeListTableViewCell : UITableViewCell {

    static let identifier = "CoffeListTableViewCell"
    
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var grade: UILabel!
    @IBOutlet weak var dateMade: UILabel!
    
    func setup(drink: Coffee) {
        titleLbl.text = drink.title
        grade.text = drink.GoodOrNot
        dateMade.text = drink.desc
    }
}
