//
//  ETHTokenPriceInfo.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/5/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class ETHTokenPriceInfo: Mappable {
    var rate:String?
    var diff:Double?
    var diff7d:Double?
    var ts:String?
    var marketCapUsd:String?
    var availableSupply:String?
    var volume24h:String?
    var diff30d:Double?
    var currency:String?
    required public init?(map: Map) {}

    public func mapping(map: Map) {
        rate <- map["rate"]
        diff <- map["diff"]
        diff7d <- map["diff7d"]
        ts <- map["ts"]
        marketCapUsd <- map["marketCapUsd"]
        availableSupply <- map["availableSupply"]
        volume24h <- map["volume24h"]
        diff30d <- map["diff30d"]
        currency <- map["currency"]
    }

    //    /*"price":{"rate":"0.00146033","diff":8.22,"diff7d":0.23,"ts":"1530773062","marketCapUsd":"8274991.0","availableSupply":"5666521283.0","volume24h":"37071.9","diff30d":-42.570679125227,"currency":"USD"}
}
