//
//  CryptoCurrencyType.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 6/29/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
public enum CryptoCurrencyType {
    case COIN
    case TOKEN
}
public enum TokenType {
    case ETH_ERC_20
    case ETH_ERC_721
    case ETH_ERC_1155
}
public enum ETHTransactionType {
    case Normal
    case Internal
    case ERC20Tranx
}
public enum CryptoDivisibleNumber:Int {
    case BTC = 8
    case ETH = 18
    case NEO = 0
}
public enum CryptoDecimal: Double {
    case BTC = 100000000
    case ETH =  1000000000000000000
    case GWEI = 1000000000
    case NEO = 1
}
