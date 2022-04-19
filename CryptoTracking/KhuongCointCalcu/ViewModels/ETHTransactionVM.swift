//
//  ETHTransactionVM.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/21/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
struct ETHTransactionVM {
    var ethTxInfo:ETHTransaction?
    var transactionType:ETHTransactionType = .Normal
    //
    var blockNumber : String {
        get {
            return ethTxInfo?.blockNumber ?? ""
        }
        set (newValue) {
            ethTxInfo?.blockNumber = newValue
        }
    }
    var timeStamp : String {
        get {
            return ethTxInfo?.timeStamp ?? ""
        }
    }
    var onlyDate:String {
        get {
            let date:Date = Date(timeIntervalSince1970: Double(ethTxInfo?.timeStamp ?? "0")!)
            return date.dateString(withFormat: FORMAT_DATE.MMM_D_YYYY)
        }
    }
    var onlyTime:String {
        get {
            let date:Date = Date(timeIntervalSince1970: Double(ethTxInfo?.timeStamp ?? "0")!)
            return date.dateString(withFormat: FORMAT_DATE.HH_MM_A)
        }
    }
    var fullTime:String {
        get {
            let date:Date = Date(timeIntervalSince1970: Double(ethTxInfo?.timeStamp ?? "0")!)
            return date.dateString(withFormat: FORMAT_DATE.MMM_D_YYYY_HH_MM_A)
        }
    }
    var hash : String {
        get {
            return ethTxInfo?.hash ?? ""
        }
    }
    var nonce : String {
        get {
            return ethTxInfo?.nonce ?? ""
        }
    }
    var blockHash : String {
        get {
            return ethTxInfo?.blockHash ?? ""
        }
    }
    var from : String {
        get {
            return ethTxInfo?.from ?? ""
        }
    }
    var contractAddress : String {
        get {
            return ethTxInfo?.contractAddress ?? ""
        }
    }
    var to : String {
        get {
            return ethTxInfo?.to ?? ""
        }
    }
    var ethValue : String {
        get {
            if self.transactionType == .Normal ||  self.transactionType == .Internal {
                let statusNum = ValuesUtils.shared.getETH_staticNum(decimals: "18")
                let dValue = Double(ethTxInfo?.value ?? "0") ?? 0
                let display = dValue/statusNum

                return display.description + " " + "Ether"
            }
            return ethTxInfo?.value ?? ""
        }
    }

    var value : String {
        get {
            if self.transactionType == .Normal ||  self.transactionType == .Internal {
                let statusNum = ValuesUtils.shared.getETH_staticNum(decimals: "18")
                let dValue = Double(ethTxInfo?.value ?? "0") ?? 0
                let display = dValue/statusNum

                let ethExchangeData = GlobalValue.shared.marketExchangeData[CryptoListing.shared._Ethereum.symbol]
                let price = ethExchangeData?.price!
                let k = CurrencyFormatter.shared.formatAmount(display * price!, currency: FLAT_CURRENCY.USD.rawValue, options: nil)

                return display.description + " " + "Ether" + " (\(k))"
            }
            return ethTxInfo?.value ?? ""
        }
    }
    var tokenName : String {
        get {
            return ethTxInfo?.tokenName ?? ""
        }
    }
    var tokenSymbol : String {
        get {
            return ethTxInfo?.tokenSymbol ?? ""
        }
    }
    var tokenDecimal : String {
        get {
            return ethTxInfo?.tokenDecimal ?? ""
        }
    }
    var transactionIndex : String {
        get {
            return ethTxInfo?.transactionIndex ?? ""
        }
    }
    var gas : String {
        get {
            return ethTxInfo?.gas ?? ""
        }
    }
    var gasPrice : String {
        get {
            if self.transactionType == .Normal ||  self.transactionType == .Internal {
                let statusNum = ValuesUtils.shared.getETH_staticNum(decimals: "18")
                let dValue = Double(ethTxInfo?.gasPrice ?? "0") ?? 0
                let display = dValue/statusNum
                let gwei = display * 1000000000
                return "\(gwei) GWEI"
            }
            return ethTxInfo?.gasPrice ?? ""
        }
    }
    var gasUsed : String {
        get {
            return ethTxInfo?.gasUsed ?? ""
        }
    }
    var cumulativeGasUsed : String {
        get {
            return ethTxInfo?.cumulativeGasUsed ?? ""
        }
    }
    var input : String {
        get {
            return ethTxInfo?.input ?? ""
        }
    }
    var confirmations : String {
        get {
            return ethTxInfo?.confirmations ?? ""
        }
    }
    var status:String {
        get {
            return (ethTxInfo?.isError ?? "0" ) == "0" ? "Success" : "Error"
        }
    }
    var test:String {

            return (ethTxInfo?.isError ?? "0" ) == "0" ? "Success" : "Error"
    }
    var txFee : String {
        //tx fee = (gasPrice * gasUsed) / 1000000000000000000
        get {
            let dgasUsed = Double(gasUsed) ?? 0
            let dgasPrice = Double(ethTxInfo?.gasPrice ?? "0") ?? 0
            let result = dgasPrice * dgasUsed / ValuesUtils.shared.getETH_staticNum(decimals: "18")
            //flat fee
            let ethExchangeData = GlobalValue.shared.marketExchangeData[CryptoListing.shared._Ethereum.symbol]
            let price = ethExchangeData?.price!
            let k = CurrencyFormatter.shared.formatAmount(result * price!, currency: FLAT_CURRENCY.USD.rawValue, options: nil)
            return result.description + " (\(k))" //(result * price!).description
        }
    }

    var imgBgUrl: URL? {
        get {
            let imageName = "img_token_BG" // your image name here
            let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName).jpg"

            let img = "https://drive.google.com/uc?id=0B5_EDc0eM5_NaW1valRxZGEycDA"
            return URL.init(fileURLWithPath: imagePath)
        }
    }
    var imgLogoUrl: URL? {
        get {
            return URL.init(string:"")
        }
    }
    //
    init() {
        ethTxInfo = ETHTransaction()
    }
    init(txInfo:ETHTransaction) {
        self.ethTxInfo = txInfo
    }
    init(txInfo:ETHTransaction, transactionType type:ETHTransactionType) {
        self.ethTxInfo = txInfo
        self.transactionType = type
    }
}
