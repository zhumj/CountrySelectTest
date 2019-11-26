//
//  CountryPickerController.swift
//  CountrySelectTest
//
//  Created by admin on 2019/11/25.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit

class CountryPickerController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private let tableCellID = "reuseIdentifier"
    private let collectionCellID = "Cell"
    
    private var collectionSelectIndex: Int = 0
    
    private var selectedCountry: CountryModel? = nil
    private var selectedRegion: RegionModel? = nil
    private var selectedCity: String? = nil
    
    open class func open(superController: UIViewController, countrie: [CountryModel], backClock: ((_ model: CountrySelectedModel) -> Void)?) {
        let controller = CountryPickerController()
        controller.view.backgroundColor = UIColor.clear
        controller.modalPresentationStyle = .custom
        controller.countrie = countrie
        controller.backClock = backClock
        superController.present(controller, animated: true, completion: nil)
    }

    var backClock: ((_ model: CountrySelectedModel) -> Void)? = nil
    var countrie: [CountryModel] = []
    
    //取消按钮
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CountryPickerController {
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        contentViewHeight.constant = UIScreen.main.bounds.height * 3 / 5
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableCellID)
        tableView.tableFooterView = UIView()
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelf)))
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}

//UICollectionView代理
extension CountryPickerController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //自定义Cell宽度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: String
        let index = indexPath.row
        if index == 0 {
            label = selectedCountry?.country ?? "请选择"
        } else if index == 1 {
            label = selectedRegion?.region ?? "请选择"
        } else {
            label = selectedCity ?? "请选择"
        }
        let width = label.stringWidthWithFont(font: UIFont(name: "EuphemiaUCAS", size: 17)!, maxHeight: collectionView.bounds.height)
        return CGSize(width: width + 10, height: collectionView.bounds.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count: Int
        if selectedCountry == nil {
            count = 1
        } else {
            if selectedRegion == nil {
                count = 2
            } else {
                count = 3
            }
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        let label = UILabel()
        let selectedLadel = UILabel()
        label.textAlignment = .center
        selectedLadel.textAlignment = .center
        if collectionSelectIndex == indexPath.row {
            label.textColor = UIColor.blue
            selectedLadel.textColor = UIColor.blue
        } else {
            label.textColor = UIColor.black
            selectedLadel.textColor = UIColor.black
        }
        label.text = "请选择"
        selectedLadel.text = "请选择"
        let index = indexPath.row
        if index == 0 {
            if selectedCountry != nil {
                label.text = selectedCountry!.country
                selectedLadel.text = selectedCountry!.country
            }
        } else if index == 1 {
            if selectedRegion != nil {
                label.text = selectedRegion!.region
                selectedLadel.text = selectedRegion!.region
            }
        } else {
            if selectedCity != nil {
                label.text = selectedCity!
                selectedLadel.text = selectedCity!
            }
        }

        cell.backgroundView = label
        cell.selectedBackgroundView = selectedLadel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionSelectIndex = indexPath.row
        collectionView.reloadData()
        tableView.reloadData()
        
        //点击之后 tableView 自动滚动
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        if collectionSelectIndex == 0 {
            if selectedCountry != nil {
                for i in 0 ..< countrie.count {
                    if selectedCountry?.country == countrie[i].country {
                        tableView.scrollToRow(at: IndexPath(row: i, section: 0), at: .top, animated: false)
                        return
                    }
                }
            }
        } else if collectionSelectIndex == 1 {
            if selectedCountry != nil && selectedRegion != nil{
                let regions = selectedCountry!.regions
                for i in 0 ..< regions.count {
                    if selectedRegion?.region == regions[i].region {
                        tableView.scrollToRow(at: IndexPath(row: i, section: 0), at: .top, animated: false)
                        return
                    }
                }
            }
        } else {
            if selectedRegion != nil && selectedCity != nil {
                let cities = selectedRegion!.cities
                for i in 0 ..< cities.count {
                    if selectedCity == cities[i] {
                        tableView.scrollToRow(at: IndexPath(row: i, section: 0), at: .top, animated: false)
                        return
                    }
                }
            }
        }
    }
}

//UITableView代理
extension CountryPickerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count: Int
        if collectionSelectIndex == 0 {
            count = countrie.count
        } else if collectionSelectIndex == 1 {
            count = selectedCountry?.regions.count ?? 0
        } else {
            count = selectedRegion?.cities.count ?? 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath)
        
        if collectionSelectIndex == 0 {
            let countryModel = countrie[indexPath.row]
            cell.textLabel?.text = countryModel.country ?? ""
            if selectedCountry?.country == countryModel.country {
                cell.imageView?.image = UIImage(named: "country_selected")
            } else {
                cell.imageView?.image = UIImage()
            }
        } else if collectionSelectIndex == 1 {
            let regionModel = selectedCountry?.regions[indexPath.row]
            cell.textLabel?.text = regionModel?.region ?? ""
            if selectedRegion?.region == regionModel?.region {
                cell.imageView?.image = UIImage(named: "country_selected")
            } else {
                cell.imageView?.image = UIImage()
            }
        } else {
            let city = selectedRegion!.cities[indexPath.row]
            cell.textLabel?.text = city
            if city == selectedCity {
                cell.imageView?.image = UIImage(named: "country_selected")
            } else {
                cell.imageView?.image = UIImage()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if collectionSelectIndex == 0 {
            selectedCountry = countrie[indexPath.row]
            selectedRegion = nil
            selectedCity = nil
            if (selectedCountry?.regions.count ?? 0) <= 0 {
                backClock?(CountrySelectedModel(country: selectedCountry?.country ?? ""))
                self.dismiss(animated: true, completion: nil)
                return
            }
        } else if collectionSelectIndex == 1 {
            selectedRegion = selectedCountry!.regions[indexPath.row]
            selectedCity = nil
            if (selectedRegion?.cities.count ?? 0) <= 0 {
                backClock?(CountrySelectedModel(country: selectedCountry?.country ?? "", region: selectedRegion?.region ?? ""))
                self.dismiss(animated: true, completion: nil)
                return
            }
        } else {
            selectedCity = selectedRegion!.cities[indexPath.row]
            backClock?(CountrySelectedModel(country: selectedCountry?.country ?? "", region: selectedRegion?.region ?? "", city: selectedCity ?? ""))
            self.dismiss(animated: true, completion: nil)
            return
        }
        collectionSelectIndex += 1
        tableView.reloadData()
        collectionView.reloadData()
        
        //点击之后 tableView 自动滚动
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
}
