//
//  ETHTransaction.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/19/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import ObjectMapper
open class ETHTransactionResponse : Mappable {
    var status : String?
    var message : String?
    var result : [ETHTransaction]?

    required public init?(map: Map) {

    }
    public func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

open class ETHTransaction : Mappable {
    var blockNumber : String?
    var timeStamp : String?
    var hash : String?
    var nonce : String?
    var blockHash : String?
    var from : String?
    var contractAddress : String?
    var to : String?
    var value : String?
    var tokenName : String?
    var tokenSymbol : String?
    var tokenDecimal : String?
    var transactionIndex : String?
    var gas : String?
    var gasPrice : String?
    var gasUsed : String?
    var cumulativeGasUsed : String?
    var input : String?
    var confirmations : String?
    var isError:String?
    var txreceipt_status:String?
    var searchAddress:String = ""
    
    required public init?(map: Map) {}
    init() {}

    public func mapping(map: Map) {
        blockNumber <- map["blockNumber"]
        timeStamp <- map["timeStamp"]
        hash <- map["hash"]
        nonce <- map["nonce"]
        blockHash <- map["blockHash"]
        from <- map["from"]
        contractAddress <- map["contractAddress"]
        to <- map["to"]
        value <- map["value"]
        tokenName <- map["tokenName"]
        tokenSymbol <- map["tokenSymbol"]
        tokenDecimal <- map["tokenDecimal"]
        transactionIndex <- map["transactionIndex"]
        gas <- map["gas"]
        gasPrice <- map["gasPrice"]
        gasUsed <- map["gasUsed"]
        cumulativeGasUsed <- map["cumulativeGasUsed"]
        input <- map["input"]
        confirmations <- map["confirmations"]
        isError <- map["isError"]
        txreceipt_status <- map["txreceipt_status"]
    }
}

