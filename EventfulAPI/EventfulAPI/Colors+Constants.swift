//
//  Colors+Constants.swift
//  EventfulAPI
//
//  Created by Mindy Lou on 1/27/17.
//  Copyright © 2017 Mindy Lou. All rights reserved.
//

import Foundation
import UIKit

// Color palette

extension UIColor {
    class var dtwFadedRed: UIColor {
        return UIColor(red: 221.0 / 255.0, green: 53.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwFadedRed85: UIColor {
        return UIColor(red: 221.0 / 255.0, green: 52.0 / 255.0, blue: 60.0 / 255.0, alpha: 0.85)
    }
    
    class var dtwFadedRed65: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 124.0 / 255.0, blue: 129.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwPaleTeal: UIColor {
        return UIColor(red: 139.0 / 255.0, green: 207.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwSlateGrey: UIColor {
        return UIColor(red: 95.0 / 255.0, green: 96.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwWhite: UIColor {
        return UIColor(white: 252.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwPaleGrey: UIColor {
        return UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwCoolGrey: UIColor {
        return UIColor(red: 179.0 / 255.0, green: 182.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwSilver: UIColor {
        return UIColor(red: 209.0 / 255.0, green: 211.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0)
    }
    
    class var dtwBlack85: UIColor {
        return UIColor(red: 46.0 / 255.0, green: 33.0 / 255.0, blue: 33.0 / 255.0, alpha: 0.85)
    }
}

// Text styles

extension UIFont {
    class func dtw27RedLightFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 27.0)
    }
    
    class func dtw27LightGrayLightFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 27.0)
    }
    
    class func dtw16WhiteRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 16.0)
    }
    
    class func dtw16RedRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 16.0)
    }
    
    class func dtw16DarkGrayRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 16.0)
    }
    
    class func dtw14DarkGrayRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 14.0)
    }
    
    class func dtw14LightGrayRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 14.0)
    }
    
    class func dtw14WhiteRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 14.0)
    }
    
    class func dtw14RedRegularFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 14.0)
    }
    
    class func dtw14DarkGrayLightFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: 14.0)
    }
}
