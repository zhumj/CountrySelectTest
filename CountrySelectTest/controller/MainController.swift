//
//  MainController.swift
//  CountrySelectTest
//
//  Created by admin on 2019/11/25.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit
import HandyJSON

class MainController: UIViewController {

    @IBOutlet weak var btnSelectCountry: UIButton!
    
    //获取国家列表
    private var countries: [CountryModel] {
        var countrys: [CountryModel] = []
        for i in 1...24 {
            let countryModel = CountryModel(country: "国家\(i)")
            
            switch i {
            case 1, 3, 5 , 7 , 9, 11, 13, 15, 17, 19, 21, 23:
                countryModel.regions = getRegionData(hasRegion: true, hasCity: true)
                break
            case 2:
                countryModel.regions = getRegionData(hasRegion: true, hasCity: false)
                break
            default:
                countryModel.regions = getRegionData(hasRegion: false, hasCity: false)
                break
            }
            
            countrys.append(countryModel)
        }
        return countrys
    }
    
    //获取洲列表
    private func getRegionData(hasRegion: Bool, hasCity: Bool) -> [RegionModel] {
        var regions: [RegionModel] = []
        if hasRegion {
            for i in 1...24 {
                let regionModel = RegionModel(region: "洲\(i)")
                
                if hasCity {
                    regionModel.cities = getCityDate(hasCity: hasCity)
                }
                
                regions.append(regionModel)
            }
        }
        return regions
    }
    
    //获取城市列表
    private func getCityDate(hasCity: Bool) -> [String] {
        var cities: [String] = []
        if hasCity {
            for i in 1...24 {
                cities.append("城市\(i)")
            }
        }
        return cities
    }

    @IBAction func selectCountryAction(_ sender: Any) {
        CountryPickerController.open(superController: self, countrie: countries) { (model) in
            self.btnSelectCountry.setTitle("\(model.country ?? "") \(model.region ?? "") \(model.city ?? "")", for: .normal)
        }
    }
    
}
