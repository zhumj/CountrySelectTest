//
//  CountrySelectedModel.swift
//  CountrySelectTest
//
//  Created by admin on 2019/11/25.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import HandyJSON

class CountrySelectedModel: HandyJSON {
    var country: String? = nil
    var region: String? = nil
    var city: String? = nil
    
    required init() {}
    
    init(country: String) {
        self.country = country
    }
    
    init(country: String, region: String) {
        self.country = country
        self.region = region
    }
    
    init(country: String, region: String, city: String) {
        self.country = country
        self.region = region
        self.city = city
    }
}
