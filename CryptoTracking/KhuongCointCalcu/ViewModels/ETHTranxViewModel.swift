//
//  ETHTranxViewModel.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/23/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
class ETHTranxViewModel: BaseTableViewViewModelProtocol {

    typealias T = String
    
    var request: String = "" {
        didSet {
            fetchData()
        }
    }
    
    var transactions:[ETHTransaction] = [] {
        didSet {
            self.fetchDataCompletion?()
        }
    }
    
    var fetchDataCompletion: (() -> Void)?
    
    var hasData: Bool {
        return transactions.count > 0
    }
    
    var noDataMessage: String = ""
    
    var availableFetchData: Bool  = true
    
    var searchAddress:String = "" {
        didSet{
            request = makeRequestUrl()
        }
    }
    
    var numberOfSection: Int {
        return 1
    }
    var ethTransType:ETHTransactionType = .Normal
    init() {}
    init(with ethTransType: ETHTransactionType) {
        self.ethTransType = ethTransType
    }
    
    func numberOfRowInSection(section: Int) -> Int {
        guard transactions.indices.contains(section) else {
            return 0
        }
        return transactions.count
    }
    func getETHTransaction(at index:Int) -> ETHTransaction? {
        guard self.transactions.indices.contains(index) else {
            return nil
        }
        return self.transactions[index]
    }
    func getTranx(at index:Int) -> ETHTransactionRepresentable? {
        guard self.transactions.indices.contains(index) else {
            return nil
        }
        return self.transactions[index]
    }
    private func makeRequestUrl() -> String {
        let apiKey = ValuesUtils.shared.ETH_EtherScanAPIKey
        var url:String = "http://api.etherscan.io/api?module=account&action=txlist&address=\(searchAddress)&startblock=0&endblock=999999999&sort=desc&apikey=\(apiKey)" // Normal Transaction as default value
        if self.ethTransType == .ERC20Tranx {
            url = "http://api.etherscan.io/api?module=account&action=tokentx&address=\(searchAddress)&startblock=0&endblock=999999999&sort=desc&apikey=\(apiKey)"
        }
        return url

    }
    func fetchData() {
        Network.shared.sendRequestWithResponseObj(requestUrl: self.request) {[weak self] (response: DataResponse<ETHTransactionResponse>) in
            guard let data = response.result.value else {
                self?.transactions = []
                return
            }
            if let transx = data.result {
                let _transx = transx.compactMap({ (ethTx) -> ETHTransaction in
                    ethTx.searchAddress = self?.searchAddress ?? ""
                    return ethTx
                })
                self?.transactions = _transx
                
            } else {
                self?.transactions = []
                self?.noDataMessage = data.message ?? "No Data"
            }
        }
    }
}
extension ETHTransaction : ETHTransactionRepresentable {
    
    var txDate: Date {
        return Date(timeIntervalSince1970: Double(timeStamp ?? "0")!)
    }
    var marketPrice: Double {
        let ethExchangeData = GlobalValue.shared.marketExchangeData[CryptoListing.shared._Ethereum.symbol]
        return ethExchangeData?.price! ?? 0
    }
    
    var onlyDate: String {
        get {
            return self.txDate.dateString(withFormat: FORMAT_DATE.MMM_D_YYYY)
        }
    }

    var onlyTime: String {
        get {
            return self.txDate.dateString(withFormat: FORMAT_DATE.HH_MM_A)
        }
    }
    
    var fullTime: String {
        get {
            return self.txDate.dateString(withFormat: FORMAT_DATE.MMM_D_YYYY_HH_MM_A)
        }
    }
    
    var fromAddress: String {
        get {
            return from ?? ""
        }
    }
    
    var toAddress: String {
        get {
            return to ?? ""
        }
    }
    var txType: String {
        get {
            let result = toAddress.lowercased() == searchAddress.lowercased() ? "+" : "-"
            return result
        }
    }
    
    var ethValue: String {
        get {
            let dValue = Double(value ?? "0") ?? 0.0
            let display = dValue/CryptoDecimal.ETH.rawValue
            let symbol = CryptoListing.shared._Ethereum.symbol
            let prefix:String = dValue == 0 ? "" : txType
            return prefix + CurrencyFormatter.shared.stringFromNumber(amount: display, fractionDigits: CryptoDivisibleNumber.ETH.rawValue) + " " + symbol
        }
    }
    
    var ethValueWithMarketPrice: String {
        get {
            let symbol = CryptoListing.shared._Ethereum.symbol
            let dValue = Double(value ?? "0") ?? 0
            let display = dValue/CryptoDecimal.ETH.rawValue
            let marketValue = CurrencyFormatter.shared.formatAmount(display * marketPrice, currency: FLAT_CURRENCY.USD.rawValue, options: nil)
            let prefix:String = dValue == 0 ? "" : txType
            return prefix + CurrencyFormatter.shared.stringFromNumber(amount: display, fractionDigits: CryptoDivisibleNumber.ETH.rawValue) + " \(symbol)" + " (\(marketValue))"
        }
    }
    var txFee: String {
        get {
            let dgasUsed = Double(gasUsed ?? "0") ?? 0
            let dgasPrice = Double(gasPrice ?? "0") ?? 0
            let result = dgasPrice * dgasUsed / CryptoDecimal.ETH.rawValue
            //flat fee
            let marketValue = CurrencyFormatter.shared.formatAmount(result * marketPrice, currency: FLAT_CURRENCY.USD.rawValue, options: nil)
            return CurrencyFormatter.shared.stringFromNumber(amount: result, fractionDigits: CryptoDivisibleNumber.ETH.rawValue) + " (\(marketValue))"
        }
    }
    var txStatus: Bool {
        get {
            return (isError ?? "0" ) == "0" ? true : false
        }
    }
    var txStatusDisplay: String {
        get {
            return txStatus ? "Success" : "Fail"
        }
    }
    var txStatusColor: UIColor {
        get {
            if txStatus == false {
                return XColors.shared.lightGray
            } else {
                if txType == "+" {
                    return XColors.shared.greenBgCell
                } else {
                    return XColors.shared.redBgCell
                }
            }
        }
    }
    
    var txBgStatusColor: UIColor {
        get {
            return txStatus ? XColors.shared.blueBgCell : XColors.shared.lightGray
        }
    }
    
    var txHash: String {
        get {
            return hash ?? ""
        }
    }
    
    var txGasUsed: String {
        get {
            let display = Double(gasUsed ?? "0") ?? 0
            return CurrencyFormatter.shared.stringFromNumber(amount: display, fractionDigits: 0)
        }
    }
    
    var txGasPrice: String {
        get {
            let dValue = Double(gasPrice ?? "0") ?? 0
            let display = dValue/CryptoDecimal.ETH.rawValue
            let gwei = CurrencyFormatter.shared.stringFromNumber(amount: display * CryptoDecimal.GWEI.rawValue, fractionDigits: 0)
            return "\(gwei) GWEI"
        }
    }
    
    var blockHeight: String {
        get {
            let blockNum = Double(blockNumber ?? "0") ?? 0
            return CurrencyFormatter.shared.stringFromNumber(amount: blockNum, fractionDigits: 0)
        }
    }
    
    
}
