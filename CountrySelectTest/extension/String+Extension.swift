//
//  String+Extension.swift
//  CountrySelectTest
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 zhumj. All rights reserved.
//

import UIKit

extension String {
    public func stringSizeWithFont(font: UIFont, maxHeight: CGFloat) -> CGRect {
        let attributes = [kCTFontAttributeName: font]
        let norStr = NSString(string: self)
        let size = norStr.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: maxHeight), options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return size
    }
    
    public func stringWidthWithFont(font: UIFont, maxHeight: CGFloat) -> CGFloat {
        let attributes = [kCTFontAttributeName: font]
        let norStr = NSString(string: self)
        let size = norStr.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: maxHeight), options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return size.width
    }
    
    public func stringHeightWithFont(font: UIFont, maxWidth: CGFloat) -> CGFloat {
        let attributes = [kCTFontAttributeName: font]
        let norStr = NSString(string: self)
        let size = norStr.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return size.height
    }
}
