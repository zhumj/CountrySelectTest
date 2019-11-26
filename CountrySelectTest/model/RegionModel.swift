//
//  RegionModel.swift
//  RegionSelectTest
//
//  Created by admin on 2019/11/25.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import HandyJSON

class RegionModel: HandyJSON {
    required init() {}
    
    var region: String? = nil
    var cities: [String] = []
    
    init(region: String) {
        self.region = region
    }
    
    init(region: String, cities: [String]) {
        self.region = region
        self.cities = cities
    }
}
