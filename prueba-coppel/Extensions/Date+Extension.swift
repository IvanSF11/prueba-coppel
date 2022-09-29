//
//  Date+Extension.swift
//  prueba-coppel
//
//  Created by Pedro Soriano on 27/09/22.
//

import Foundation


internal extension Date {
    func getDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "es_MX")
        return dateFormatter.string(from: date)
    }
}
