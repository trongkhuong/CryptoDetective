//
//  ResponseObject.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/3/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper

open class ResponseObject: Mappable {
    var btcData:CryptoMarketData?
    var ethData:CryptoMarketData?
    var bnbData:CryptoMarketData?
    var neoData:CryptoMarketData?
    var etcData:CryptoMarketData?
    var eosData:CryptoMarketData?
    required public init?(map: Map) { }
    public func mapping(map: Map) {
        btcData <- map[CryptoListing.shared._Bitcoin.symbol]
        ethData <- map[CryptoListing.shared._Ethereum.symbol]
        neoData <- map[CryptoListing.shared._NEO.symbol]
        etcData <- map[CryptoListing.shared._EthereumClassic.symbol]
        eosData <- map[CryptoListing.shared._EOS.symbol]
        bnbData <- map[CryptoListing.shared._BinanceCoin.symbol]
    }
}
open class CryptoMarketData: Mappable {

    var priceUSD:MarketExchangeData?
    var priceEUR:MarketExchangeData?
    var priceJPY:MarketExchangeData?
    var priceKRW:MarketExchangeData?
    var priceBTC:MarketExchangeData?
    var priceETH:MarketExchangeData?
    var priceNEO:MarketExchangeData?
    var priceBNB:MarketExchangeData?
    required public init?(map: Map) {}

    public func mapping(map: Map) {
        priceUSD <- map[FLAT_CURRENCY.USD.rawValue]
        priceEUR <- map[FLAT_CURRENCY.EUR.rawValue]
        priceJPY <- map[FLAT_CURRENCY.JPY.rawValue]
        priceKRW <- map[FLAT_CURRENCY.KRW.rawValue]
        priceBTC <- map[CryptoListing.shared._Bitcoin.symbol]
        priceETH <- map[CryptoListing.shared._Ethereum.symbol]
        priceNEO <- map[CryptoListing.shared._NEO.symbol]
        priceBNB <- map[CryptoListing.shared._BinanceCoin.symbol]
    }
}

///-------------------------------------------------------------------------------------------------------------------------------------------------------------------
open class ResponseRawObject: Mappable {
    var btcData:CryptoRawMarketData?
    var ethData:CryptoRawMarketData?
    var neoData:CryptoRawMarketData?
    var etcData:CryptoRawMarketData?
    var eosData:CryptoRawMarketData?
    var bnbData:CryptoRawMarketData?
    
    var cryptoRawMarket:[String:CryptoRawMarketData]?
    var map:Map?
    private var fromSyms:String = ""
    private var toSyms:String = ""
    required public init?(map: Map) {
        self.map = map
    }
    func initMoreData(fromSyms:String, toSyms:String) {
        self.fromSyms = fromSyms
        self.toSyms = toSyms
        let array:[String] = fromSyms.components(separatedBy: ",")
        var test:[String:CryptoRawMarketData] = [:]
        array.forEach { (st) in
            test[st] = CryptoRawMarketData.init()
        }
        cryptoRawMarket = test
    }
    
    public func mapping(map: Map) {
        self.map = map
        btcData <- map[CryptoListing.shared._Bitcoin.symbol]
        ethData <- map[CryptoListing.shared._Ethereum.symbol]
        neoData <- map[CryptoListing.shared._NEO.symbol]
        etcData <- map[CryptoListing.shared._EthereumClassic.symbol]
        eosData <- map[CryptoListing.shared._EOS.symbol]
        bnbData <- map[CryptoListing.shared._BinanceCoin.symbol]
        
        if let collect = cryptoRawMarket?.keys {
            let array = Array(collect)
            array.forEach { (st) in
                var object = CryptoRawMarketData.init()
                object <- map[st]
                object.initMoreData(toSyms: toSyms)
                object.mapping(map: object.map!)
                self.cryptoRawMarket?[st] = object
            }
        }
        
    }
}
open class CryptoRawMarketData: Mappable {

    var priceUSD:MarketRawExchangeData?
    var priceEUR:MarketRawExchangeData?
    var priceJPY:MarketRawExchangeData?
    var priceKRW:MarketRawExchangeData?
    var priceBTC:MarketRawExchangeData?
    var priceETH:MarketRawExchangeData?
    var priceNEO:MarketRawExchangeData?
    var priceBNB:MarketRawExchangeData?
    var toSymsRawMarket:[String:MarketRawExchangeData]?
    var map:Map?
    required public init?(map: Map) {
      self.map = map
    }
    init() {}
    func initMoreData(toSyms:String) {
        let array:[String] = toSyms.components(separatedBy: ",")
        var test:[String:MarketRawExchangeData] = [:]
        array.forEach { (st) in
            test[st] = MarketRawExchangeData.init()
        }
        toSymsRawMarket = test
        //print(toSymsRawMarket)
    }
    
    public func mapping(map: Map) {
        self.map = map
        priceUSD <- map[FLAT_CURRENCY.USD.rawValue]
        priceEUR <- map[FLAT_CURRENCY.EUR.rawValue]
        priceJPY <- map[FLAT_CURRENCY.JPY.rawValue]
        priceKRW <- map[FLAT_CURRENCY.KRW.rawValue]
        priceBTC <- map[CryptoListing.shared._Bitcoin.symbol]
        priceETH <- map[CryptoListing.shared._Ethereum.symbol]
        priceNEO <- map[CryptoListing.shared._NEO.symbol]
        priceBNB <- map[CryptoListing.shared._BinanceCoin.symbol]
        
        if let collect = toSymsRawMarket?.keys {
            let array = Array(collect)
            array.forEach { (st) in
                var object = MarketRawExchangeData()
                object <- map[st]
                self.toSymsRawMarket?[st] = object
            }
        }
    }
}
