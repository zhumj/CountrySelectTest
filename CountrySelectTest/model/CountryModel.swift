//
//  RegionModel.swift
//  RegionSelectTest
//
//  Created by admin on 2019/11/25.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import HandyJSON

class CountryModel: HandyJSON {
    var country: String? = nil
    var regions: [RegionModel] = []
    
    required init() {}
    
    init(country: String) {
        self.country = country
    }
    
    init(country: String, regions: [RegionModel]) {
        self.country = country
        self.regions = regions
    }
}
