//
//  TokenInfo.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/5/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class TokenInfo: Mappable {
    var address:String?
    var name:String?
    var decimals:String?
    var symbol:String?
    var totalSupply:String?
    var owner:String?
    var lastUpdated:String?
    var issuancesCount:Int?
    var holdersCount:Int?
    var image:String?
    var description:String?
    var website:String?
    var ethTransfersCount:Int?
    var price:ETHTokenPriceInfo?
    //var tokenPriceInfo: ETHTokenPriceInfo?

    required public init?(map: Map) { }
    public func mapping(map: Map) {
        address <- map["address"]
        name <- map["name"]
        decimals <- map["decimals"]
        symbol <- map["symbol"]
        totalSupply <- map["totalSupply"]
        lastUpdated <- map["lastUpdated"]
        issuancesCount <- map["issuancesCount"]
        holdersCount <- map["holdersCount"]
        description <- map["description"]
        website <- map["website"]
        ethTransfersCount <- map["ethTransfersCount"]
        price <- map["price"]
    }

}
