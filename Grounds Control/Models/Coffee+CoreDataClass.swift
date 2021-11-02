//
//  Coffee+CoreDataClass.swift
//  Grounds Control
//
//  Created by Brett on 10/22/21.
//
//

import Foundation
import CoreData

@objc(Coffee)
public class Coffee: NSManagedObject {
    var title: String {
        return name?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
        }
    var desc: String {
        return "\(created!.format())" // return second line
    }
    var GoodOrNot: String {
        return grade?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
        }

}
