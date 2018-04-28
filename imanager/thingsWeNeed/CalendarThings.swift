//
//  CalendarThings.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 14..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

var day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)


struct Univ {
    let univ_name : String
    let major : String
}
