//
//  Colors.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 6/29/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import UIKit
open class XColors {
    public static let shared = XColors()
    private init() {}

    let main:UIColor = UIColor.initColor(red: 63, green: 170, blue: 226, alpha: 1) //UIColor.initColor(red: 52, green: 152, blue: 219, alpha: 1) 63 170 226
    let red:UIColor = UIColor.red
    let lightGray:UIColor = UIColor.lightGray
    let green:UIColor = UIColor.initColor(red: 88, green: 156, blue: 117, alpha: 1) // 88 156 117
    let blueBgCell:UIColor = UIColor.initColor(red: 5, green: 122, blue: 255, alpha: 1) //Optional(UIExtendedSRGBColorSpace 0 0.478431 1 1)
    let redBgCell:UIColor = UIColor.initColor(red: 251, green: 79, blue: 1, alpha: 1)
    let greenBgCell:UIColor = UIColor.initColor(red: 5, green: 166, blue: 81, alpha: 1)
}
