//
//  CryptoMarketData.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/2/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//
import Foundation
import ObjectMapper

open class MarketExchangeData: Mappable {

    var fromSymbol:         String?
    var toSymbol:           String?
    var market:             String?
    var price:              String?
    var lastUpdate:         String?
    var lastVolume:         String?
    var lastVolumeTo:       String?
    var lastTradeId:        String?
    var volumeDay:          String?
    var volumeDayTo:        String?
    var volume24Hour:       String?
    var volume24HourTo:     String?
    var openDay:            String?
    var highDay:            String?
    var lowDay:             String?
    var open24Hour:         String?
    var high24Hour:         String?
    var low24Hour:          String?
    var lastMarket:         String?
    var change24Hour:       String?
    var changePct24Hour:    String?
    var changeDay:          String?
    var changePctDay:       String?
    var supply:             String?
    var mktCap:             String?
    var totalVolume24h:     String?
    var totalVolume24hTo:   String?

    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        self.fromSymbol         <- map["FROMSYMBOL"]
        self.toSymbol           <- map["TOSYMBOL"]
        self.market             <- map["MARKET"]
        self.price              <- map["PRICE"]
        self.lastUpdate         <- map["LASTUPDATE"]
        self.lastVolume         <- map["LASTVOLUME"]
        self.lastVolumeTo       <- map["LASTVOLUMETO"]
        self.lastTradeId        <- map["LASTTRADEID"]
        self.volumeDay          <- map["VOLUMEDAY"]
        self.volumeDayTo        <- map["VOLUMEDAYTO"]
        self.volume24Hour       <- map["VOLUME24HOUR"]
        self.volume24HourTo     <- map["VOLUME24HOURTO"]
        self.openDay            <- map["OPENDAY"]
        self.highDay            <- map["HIGHDAY"]
        self.lowDay             <- map["LOWDAY"]
        self.open24Hour         <- map["OPEN24HOUR"]
        self.high24Hour         <- map["HIGH24HOUR"]
        self.low24Hour          <- map["LOW24HOUR"]
        self.lastMarket         <- map["LASTMARKET"]
        self.change24Hour       <- map["CHANGE24HOUR"]
        self.changePct24Hour    <- map["CHANGEPCT24HOUR"]
        self.changeDay          <- map["CHANGEDAY"]
        self.changePctDay       <- map["CHANGEPCTDAY"]
        self.supply             <- map["SUPPLY"]
        self.mktCap             <- map["MKTCAP"]
        self.totalVolume24h     <- map["TOTALVOLUME24H"]
        self.totalVolume24hTo   <- map["TOTALVOLUME24HTO"]
    }
}
//
class MarketRawExchangeData: Mappable {

    var fromSymbol:         String?
    var toSymbol:           String?
    var market:             String?
    var price:              Double?
    var lastUpdate:         Double?
    var lastVolume:         Double?
    var lastVolumeTo:       Double?
    var lastTradeId:        String?
    var volumeDay:          Double?
    var volumeDayTo:        Double?
    var volume24Hour:       Double?
    var volume24HourTo:     Double?
    var openDay:            Double?
    var highDay:            Double?
    var lowDay:             Double?
    var open24Hour:         Double?
    var high24Hour:         Double?
    var low24Hour:          Double?
    var lastMarket:         String?
    var change24Hour:       Double?
    var changePct24Hour:    Double?
    var changeDay:          Double?
    var changePctDay:       Double?
    var supply:             Double?
    var mktCap:             Double?
    var totalVolume24h:     Double?
    var totalVolume24hTo:   Double?

    required init?(map: Map) {}
    init() {}
    func mapping(map: Map) {
        self.fromSymbol         <- map["FROMSYMBOL"]
        self.toSymbol           <- map["TOSYMBOL"]
        self.market             <- map["MARKET"]
        self.price              <- map["PRICE"]
        self.lastUpdate         <- map["LASTUPDATE"]
        self.lastVolume         <- map["LASTVOLUME"]
        self.lastVolumeTo       <- map["LASTVOLUMETO"]
        self.lastTradeId        <- map["LASTTRADEID"]
        self.volumeDay          <- map["VOLUMEDAY"]
        self.volumeDayTo        <- map["VOLUMEDAYTO"]
        self.volume24Hour       <- map["VOLUME24HOUR"]
        self.volume24HourTo     <- map["VOLUME24HOURTO"]
        self.openDay            <- map["OPENDAY"]
        self.highDay            <- map["HIGHDAY"]
        self.lowDay             <- map["LOWDAY"]
        self.open24Hour         <- map["OPEN24HOUR"]
        self.high24Hour         <- map["HIGH24HOUR"]
        self.low24Hour          <- map["LOW24HOUR"]
        self.lastMarket         <- map["LASTMARKET"]
        self.change24Hour       <- map["CHANGE24HOUR"]
        self.changePct24Hour    <- map["CHANGEPCT24HOUR"]
        self.changeDay          <- map["CHANGEDAY"]
        self.changePctDay       <- map["CHANGEPCTDAY"]
        self.supply             <- map["SUPPLY"]
        self.mktCap             <- map["MKTCAP"]
        self.totalVolume24h     <- map["TOTALVOLUME24H"]
        self.totalVolume24hTo   <- map["TOTALVOLUME24HTO"]
    }
}
extension MarketRawExchangeData: MarketDataRepresentable {
    
    var price24hColor: UIColor {
        let percent = self.changePct24Hour ?? 0
        if percent > 0 {
            return XColors.shared.greenBgCell
        } else if percent == 0 {
            return XColors.shared.lightGray
        } else {
            return XColors.shared.red
        }
    }
    
    var imgBgUrl: String? {
        return CryptoListing2.shared.getImgBg(symbol: self.fromSymbol ?? "")
    }
    
    var title: String {
        return self.fromSymbol ?? ""
    }
    
    var imgLogoUrl: String {
        return CryptoListing2.shared.getLogo(symbol: self.fromSymbol ?? "")
    }
    
    var detail: String {
        return CryptoListing2.shared.getCoin(symbol: self.fromSymbol ?? "")?.name ?? "Updating..."
    }
    
    var marketPrice: String {
        return CurrencyFormatter.shared.formatAmount(self.price ?? 0.0, currency: self.toSymbol ?? "USD", options: nil)
    }
    
    var marketPrice24h: String {
        return  CurrencyFormatter.shared.toPercent(fromDouble: self.changePct24Hour ?? 0.0)
    }
    
    var marketCap: String {
        return CurrencyFormatter.shared.formatAmount(self.mktCap ?? 0.0, currency: self.toSymbol ?? "USD", options: nil, fractionDigits: 0)
    }
    var low24hPrice: String {
        return CurrencyFormatter.shared.formatAmount(self.low24Hour ?? 0.0, currency: self.toSymbol ?? "USD", options: nil, fractionDigits: 0)
    }
    
    var high24hPrice: String {
        return CurrencyFormatter.shared.formatAmount(self.high24Hour ?? 0.0, currency: self.toSymbol ?? "USD", options: nil, fractionDigits: 0)
    }
    var volumn24h: String {
        return CurrencyFormatter.shared.formatAmount(self.totalVolume24hTo ?? 0.0, currency: self.toSymbol ?? "USD", options: nil, fractionDigits: 0)
    }
    
    var widgetTitle: String {
        return (self.fromSymbol ?? "") + "/" + (self.toSymbol ?? "")
    }
    
    var widgetMarketPrice24h: String {
        let percent = self.changePct24Hour ?? 0
        let string = percent > 0 ? "+" : ""
        return string + marketPrice24h
    }
    
    
}

