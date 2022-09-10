//
//  DateExtension.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import Foundation

extension Date {
    func dateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
