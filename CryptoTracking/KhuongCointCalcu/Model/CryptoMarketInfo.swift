//
//  HomeModel.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 10/9/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
struct CryptoMarketInfo {
    var cryptoName:String = ""
    var cryptoSymbol:String = ""
    var img_bg:String = ""
    var img_logo:String = ""
    var marketPrice:String = "" //
    var flatCurrency:String = "" // BTC, USD, EUR, bla bla
    var changed24h:String = "" //
    var changed24hDisplay:String {
        get {return changed24h + "%" }
    }
    var changed:Double {
        get {
            return Double(changed24h) ?? 0
        }
    }
//    init(name:String, symbol:String, img_bg:String, logo:String, price:String, currency:String, changed:String) {
//        self.cryptoName = name
//        self.cryptosymbol = symbol
//        self.img_bg = img_bg
//        self.img_logo = logo
//        self.marketPrice = price
//        self.flatCurrency = currency
//        self.changed24h = changed
//    }

}
