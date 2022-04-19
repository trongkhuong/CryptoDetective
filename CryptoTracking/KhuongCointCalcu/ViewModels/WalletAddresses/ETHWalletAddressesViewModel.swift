//
//  WalletAddressesVM.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/5/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
class ETHWalletAddressesViewModel:WalletAddressProtocol {
    
    init(address:[ETHWalletAddress]) {
        self.walletAddresses = address
    }
    var walletAddresses:[ETHWalletAddress] = []
    
    var fetchDataCompletion: (() -> Void)?
    
    var hasData: Bool = false
    
    var noTransactionMessage: String {
        set (newValue) {
            self.noTransactionMessage = newValue
        }
        get {
            return ""
        }
    }
    
    var availableFetchData: Bool = true
    
    var numberOfSection: Int = 1
    
    
    func numberOfRowInSection(section: Int) -> Int {
        return walletAddresses.count
    }
    
    func fetchData() {
        
    }
    
    func getInfoByIndex(indexPath: IndexPath) -> WalletAddressRepresentable? {
        guard walletAddresses.indices.contains(indexPath.row) else {
            return nil
        }
        return walletAddresses[indexPath.row]
    }
    func getWalletAddress(at index:Int) -> ETHWalletAddress? {
        guard walletAddresses.indices.contains(index) else {
            return nil
        }
        return walletAddresses[index]
    }
    
}
extension ETHWalletAddress: WalletAddressRepresentable {
    var walletAlias: String {
        get {
            return "Wallet Alias"
        }
        set (newValue) {
            self.walletAlias = newValue
        }
    }
    
    var addressDisplay: String {
        return address ?? ""
    }
    
    var amount: String { // amount of ETH
        guard var balance = eTH?.balance else {
            return "0"
        }
        balance = balance/CryptoDecimal.ETH.rawValue //ValuesUtils.shared.getETH_staticNum(decimals: CryptoDivisibleNumber.ETH.rawValue)
        let symbol = CryptoListing.shared._Ethereum.symbol
        return CurrencyFormatter.shared.stringFromNumber(amount: balance, fractionDigits: CryptoDivisibleNumber.ETH.rawValue) + " " + symbol
       
    }
    
    var value: String {
        guard var balance = eTH?.balance else {
            return "$0"
        }
        balance = balance/CryptoDecimal.ETH.rawValue //ValuesUtils.shared.getETH_staticNum(decimals: CryptoDivisibleNumber.ETH.rawValue)
        let marketPrice = GlobalValue.shared.marketExchangeData[CryptoListing.shared._Ethereum.symbol]?.price ?? 0.0
        return CurrencyFormatter.shared.formatAmount(balance * marketPrice, currency: FLAT_CURRENCY.USD.rawValue, options: nil, fractionDigits: 1)
    }
    
}
/*
extension ETHWalletAddressesViewModel {
    
    var walletInfo:ETHWalletAddress?
    var address:String {
        return walletInfo?.address ?? "loading..."
    }
    var balance:String {
        return (String(format:"%.2f", walletInfo?.eTH?.balance ?? 0) ) + " " + "Ether"
    }
    var tokenDisplay:String {
        var result = ""
        let tokens = self.getTokenHasPrice()
        tokens.forEach { (tokenSumary) in
            result += String.init(format: "%.1f", (tokenSumary.balance ?? 0.0) / ValuesUtils.shared.getETH_staticNum(decimals: tokenSumary.tokenInfo?.decimals ?? "0"))
            result += " " + (tokenSumary.tokenInfo?.name ?? "")
            result += " (" + self.calcuTotalValue(token: tokenSumary).toString() + " USD)"
            result += "\n"
        }
        return result
    }


    private func getTokenHasPrice() -> [TokenSummary] {
        var result:[TokenSummary] = []
        if let tokens = walletInfo?.tokens {
            tokens.forEach { (tokenSummary) in
                if let tokenInfo = tokenSummary.tokenInfo {
                    if let _ = tokenInfo.price {
                        result.append(tokenSummary)
//                        if let priceInfo:ETHTokenPriceInfo = Mapper<ETHTokenPriceInfo>().map(JSONString: priceJsonString) {
//                            tokenSummary.tokenInfo?.tokenPriceInfo = priceInfo
//                            result.append(tokenSummary)
//                        }
                    }
                }
            }
        }
        return result
    }
    private func calcuTotalValue(token:TokenSummary) -> Double {
        let balance = (token.balance ?? 0.0) / ValuesUtils.shared.getETH_staticNum(decimals: token.tokenInfo?.decimals ?? "0")
        let price = Double(token.tokenInfo?.price?.rate ?? "0") ?? 0
        return balance * price
    }
}
*/
