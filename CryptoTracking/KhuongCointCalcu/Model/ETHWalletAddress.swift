//
//  WalletAddress.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/5/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class ETHWalletAddress : BaseModel {
    var address : String?
    var eTH : EtherInfo?
    var countTxs : Int?
    var contractInfo : ContractInfo?
    var tokens : [TokenSummary]?

    required public init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }

    override public func mapping(map: Map) {
        address <- map["address"]
        eTH <- map["ETH"]
        countTxs <- map["countTxs"]
        contractInfo <- map["contractInfo"]
        tokens <- map["tokens"]
    }
}
open class TokenSummary:Mappable {
    var balance: Double?
    var totalIn: Int?
    var totalOut:Int?
    var tokenInfo:TokenInfo?

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        balance <- map["balance"]
        totalIn <- map["totalIn"]
        totalOut <- map["totalOut"]
        tokenInfo <- map["tokenInfo"]
    }


    /*{"tokenInfo":{
     "address":"0xda6cb58a0d0c01610a29c5a65c303e13e885887c",
     "name":"cVToken", "decimals":"18",
     "symbol":"cV",
     "totalSupply":"9931143978000000000000000000",
     "owner":"0xda6cb58a0d0c01610a29c5a65c303e13e885887c",
     "lastUpdated":1530770921,
     "issuancesCount":0,
     "holdersCount":22170,
     "ethTransfersCount":0,
     "price":{"rate":"0.00146033","diff":8.22,"diff7d":0.23,"ts":"1530773062","marketCapUsd":"8274991.0","availableSupply":"5666521283.0","volume24h":"37071.9","diff30d":-42.570679125227,"currency":"USD"}
     },
     "balance":3.02589e+23,"totalIn":0,"totalOut":0}*/
}
open  class EtherInfo : Mappable {
    var balance : Double?
    required public init?(map: Map) { }
    init() { }
    public func mapping(map: Map) {
        self.balance <- map["balance"]
    }
}
open  class ContractInfo : Mappable {
    var creatorAddress : String?
    var transactionHash : String?
    var timestamp : Int?

    required public init?(map: Map) { }

    public func mapping(map: Map) {
        creatorAddress  <- map["creatorAddress"]
        transactionHash <- map["transactionHash"]
        timestamp       <- map["timestamp"]
    }


}
