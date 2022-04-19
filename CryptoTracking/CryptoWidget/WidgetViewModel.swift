//
//  WidgetViewModel.swift
//  CryptoWidget
//
//  Created by Tran Khuong on 2/19/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
import Alamofire
class WidgetViewModel: BaseTableViewViewModelProtocol {
    typealias T = [String:String]
    private var timer = Timer()
    var noDataMessage: String = ""
    var availableFetchData: Bool = true
    
    var request: [String:String] = [:] {
        didSet {
            fetchData()
        }
    }
    
    var numberOfSection: Int {
        return 1
    }
    func numberOfRowInSection(section: Int) -> Int {
        return marketData.count
    }
    
    var marketData: [MarketRawExchangeData] = [] {
        didSet {
            fetchDataCompletion?()
        }
    }

    var hasData: Bool {
        return  marketData.count > 0
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
        let url = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=\(request["fsyms"]!)&tsyms=\(request["tsyms"]!)" 
        Network.shared.sendRequestWithResponseObj(requestUrl: url) { [weak self] (response: DataResponse<ResponseMarketData>) in
            guard let data = response.result.value else {
                self?.marketData = []
                return
            }
            var _marketData:[MarketRawExchangeData] = []
            //BTC
            if let rawBtc = data.rawObject?.btcData, let rawBtcMarket = rawBtc.priceUSD {
                _marketData.append(rawBtcMarket)
            }
            //ETH
            if let rawEth = data.rawObject?.ethData, let rawEthMarket = rawEth.priceUSD {
                _marketData.append(rawEthMarket)
            }
            if let rawBNB = data.rawObject?.bnbData, let rawBnbMarket = rawBNB.priceUSD {
                _marketData.append(rawBnbMarket)
            }
            //NEO
            if let rawNeo = data.rawObject?.neoData, let rawNeoMarket = rawNeo.priceUSD {
                _marketData.append(rawNeoMarket)
            }
            //EOS
            if let rawEOS = data.rawObject?.eosData, let rawEOSMarket = rawEOS.priceUSD {
                _marketData.append(rawEOSMarket)
            }
            //ETC
            if let rawETC = data.rawObject?.etcData, let rawETCMarket = rawETC.priceUSD {
                _marketData.append(rawETCMarket)
            }
            self?.marketData = _marketData
        }
    }
    func stopUpdateData() {
        timer.invalidate()
    }
    func updatData() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: {[weak self] (timer) in
            print("update data")
            self?.fetchData()
        })
    }
}
extension WidgetViewModel {
    func fetchData() {
        Network.shared.sendRequestMarketData(requestData: self.request) {[weak self] (response) in
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
    func getAllKey(from _dict: [String:MarketRawExchangeData]?) -> [String]? {
        guard let dict = _dict else {
            return nil
        }
        return Array(dict.keys)
    }
}
