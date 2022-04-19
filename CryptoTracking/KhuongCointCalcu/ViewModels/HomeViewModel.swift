//
//  HomeViewModel.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/2/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
class HomeViewModel {

    var marketData: [MarketRawExchangeData] = [] {
        didSet {
            fetchDataCompletion?()
        }
    }
    var query:[String:String] = [:] {
        didSet {
            fetchData()
        }
    }
    var hasData: Bool {
        return numberOfCoin > 0
    }
    var numeberOfSection: Int {
        return 1
    }
    var numberOfCoin: Int {
        return marketData.count
    }
    
    
    
    var fetchDataCompletion:(() -> Void)?

    //MARK: - METHOD
    func marketInfo(at index: Int) -> MarketDataRepresentable? {
        guard marketData.indices.contains(index) else {
            return nil
        }
        return marketData[index]
    }
    
    func getMarketInfo(at index: Int) -> MarketRawExchangeData? {
        guard self.marketData.indices.contains(index) else {
            return nil
        }
        return self.marketData[index]
    }

    func fetchData2() {
        let url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=\(query["fsyms"]!)&tsyms=\(query["tsyms"]!)" //BTC,ETH
        Network.shared.sendRequestWithResponseObj(requestUrl: url) { [weak self] (response: DataResponse<ResponseMarketData>) in
            guard let data = response.result.value else {
                self?.marketData = []
                return
            }
            var _marketData:[MarketRawExchangeData] = []
            //BTC
            if let rawBtc = data.rawObject?.btcData, let rawBtcMarket = rawBtc.priceUSD {
                self?.updateRawPrice(symbol: CryptoListing.shared._Bitcoin.symbol, data: rawBtcMarket)
                _marketData.append(rawBtcMarket)
            }
            //ETH
            if let rawEth = data.rawObject?.ethData, let rawEthMarket = rawEth.priceUSD {
                self?.updateRawPrice(symbol: CryptoListing.shared._Ethereum.symbol, data: rawEthMarket)
                _marketData.append(rawEthMarket)
            }
            self?.marketData = _marketData
        }
    }
    func fetchData() {
        Network.shared.sendRequestMarketData(requestData: self.query) {[weak self] (response) in
            guard let data = response, let coins = data.cryptoRawMarket  else {
                self?.marketData = []
                return
            }
            var _marketData:[MarketRawExchangeData] = []
            let array = Array(coins.keys)
            array.forEach({ (key) in
                if let object = coins[key] {
                    if let keys = self?.getAllKey(from: object.toSymsRawMarket) {
                        keys.forEach({ (tsyms) in
                            if let marketPrice = object.toSymsRawMarket![tsyms] {
                                _marketData.append(marketPrice)
                            }
                        })
                    }
                }
            })
            self?.marketData = _marketData
        }
    }
    
    func updateRawPrice(symbol:String, data:MarketRawExchangeData) {
        //Tam thoi
        GlobalValue.shared.updateMarketData(symbol: symbol, exchangeData: data)
    }
    
    func currentIndexDisplay(index:Int) -> String {
        return "\(index + 1)" + "/" + "\(numberOfCoin)"
    }
    func getAllKey(from _dict: [String:MarketRawExchangeData]?) -> [String]? {
        guard let dict = _dict else {
            return nil
        }
        return Array(dict.keys)
    }
}
