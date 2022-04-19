//
//  ValuesUtils.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/8/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
// ETH
public enum ETH_Etherscan_APIModule:String {
    case Account     = "account"
    case Contract    = "contract"
    case Transaction = "transaction"
    case Blocks      = "blocks"
    case Logs        = "logs"
    case Proxy       = "proxy"
    case Stats       = "stats"
}
public enum ETH_Etherscan_APIAction:String {
    case BalanceSingle       = "balance"
    case BalanceMulti        = "balancemutil"
    case Transactions        = "txlist"
    case InternalTransaction = "txlistinternal"
    case Tokentransfer       = "tokentx"
    case BlocksMined         = "getminedblocks"
    case ContractABI         = "getabi" // Get Contract ABI for Verified Contract Source Codes
    case ContractStatus      = "getStatus" //Check Contract Execution Status
    case BlockReward         = "getbloclreward" // Get Block And Uncle Rewards by BlockNo
    case GetLogs             = "getLogs" //Get Event Logs from block number
    case GetTokenSupply      = "tokensupply" //Get ERC20-Token TotalSupply by ContractAddress
    case GetTokenBalance     = "tokenbalance" //Get ERC20-Token Account Balance for TokenContractAddress
    case GetTotalSupplyEth   = "ethsupply" //Get Total Supply of Ether
    case GetEtherLastPrice   = "ethprice" //Get ETHER LastPrice Price
}
public enum ETH_Ethplorer_APIAction:String {
    case GetTokenInfo                = "getTokenInfo"
    case GetAddressInfo              = "getAddressInfo"
    case GetTxInfo                   = "getTxInfo"
    case GetTokenHistory             = "getTokenHistory"
    case GetAddressHistory           = "getAddressHistory"
    case GetAddressTransactions      = "getAddressTransactions"
    case GetTop                      = "getTop"
    case GetTopTokens                = "getTopTokens"
    case GetTokenHistoryGrouped      = "getTokenHistoryGrouped"
    case GetTokenPriceHistoryGrouped = "getTokenPriceHistoryGrouped"
}
public enum MARKET_APIAction:String {
    case GetPrice = "price"
    case MultiPrice = "pricemulti"

    // Get all the current trading info (price, vol, open, high, low etc) of any list of cryptocurrencies in any other currency that you need. If the crypto does not trade directly into the toSymbol requested, BTC will be used for conversion. This API also returns Display values for all the fields. If the oposite pair trades we invert it
    case GetPriceFull =  "pricemultifull"
}
public enum FORMAT_DATE : String {
    case YYYY_MM_DD             = "yyyy-MM-dd"
    case DD_MM_YYYY             = "dd/MM/yyyy"
    case DD_MM_YY               = "dd/MM/YY"
    case DDMMYYYY               = "ddMMyyyy"
    case DDMM                   = "dd/MM"
    case DDMM_HH_MM_A                 = "dd/MM hh:mm a"
    case DD_MM_YYYY_HH_MM       = "dd/MM/yyyy HH:mm"
    case DD_MM_YYYY_HH_MM_SS    = "dd/MM/yyyy HH:mm:ss"
    case DD_MM_YYYY_HH_MM_A     = "dd/MM/yyyy hh:mm a"
    case YYYY_MM_DD_HH_MM_SS    = "yyyy-MM-dd HH:mm:ss"
    case HH_MM_DD_MM_YYYY       = "HH:mm dd/MM/yyyy"
    case YYYY_MM_DD_HH_MM       = "yyyy-MM-dd HH:mm"
    case HH_MM                  = "HH:mm"
    case MMMYYYY                = "MMM, yyyy"
    case MMM                    = "MMM"
    case DD_MM_HH_MM            = "dd/MM HH:mm"
    case MMM_D_YYYY             = "MMM d, yyyy"
    case MMM_D_YYYY_HH_MM_A     = "MMM d, yyyy hh:mm a"
    case MMM_D                  = "MMM d"
    case D_MMM                  = "d MMM"
    case D_MMMM                 = "d MMMM"
    case HH_MM_A                = "hh:mm a"

}
public enum StoryboardList: String {
    case Main
}
open class APIURL {
    public static let shared:APIURL = APIURL()
    private init() {}
    
    let EtherScanURLString = "https://api.etherscan.io/api?module=%@&action=%@%@&apikey=\(ValuesUtils.shared.ETH_EtherScanAPIKey)"
    let EthplorerURLString = "http://api.ethplorer.io/%@/%@?apiKey=\(ValuesUtils.shared.ETH_EthplorerAPIKey)"

    let MarketURLString = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=%@&tsyms=%@"
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD,EUR
}
open class ValuesUtils {
    
    public static let shared:ValuesUtils = ValuesUtils()
    private init() {}

    let ETH_EtherScanAPIKey:String      = "PCUX7RGFPDD9KS4585EU2FG31N7UEY3G59"
    let ETH_EthplorerAPIKey:String      = "freekey"
    let marketFromSymbol:String         = "fsyms"
    let marketToSymbol:String           = "tsyms"
    
    func getETH_staticNum(decimals:String) -> Double { // = 1000000000000000000 -> 18 Decima
        let dec = Int(decimals) ?? 0
        var result:String = "1"
        for i in 0..<dec {
            result.append("0")
        }
        return Double(result) ?? 1
    }
    func getETH_staticNum(decimals:Int) -> Double { // = 1000000000000000000 -> 18 Decima
        var result:String = "1"
        for _ in 0..<decimals {
            result.append("0")
        }
        return Double(result) ?? 1
    }
}
open class GlobalValue {
    public static let shared : GlobalValue = GlobalValue()
    private init() {}

    var marketExchangeData:[String:MarketRawExchangeData] = [:]
    func updateMarketData(symbol:String, exchangeData: MarketRawExchangeData) {
        self.marketExchangeData[symbol] = exchangeData
    }
}
