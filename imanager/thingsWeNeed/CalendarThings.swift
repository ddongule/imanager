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

var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
