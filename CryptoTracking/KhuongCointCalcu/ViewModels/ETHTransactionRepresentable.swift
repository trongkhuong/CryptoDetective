//
//  ETHTransactionRepresentable.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/25/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
import UIKit
protocol ETHTransactionRepresentable {
    var onlyDate: String { get }
    var onlyTime: String { get }
    var fullTime: String { get }
    var fromAddress: String { get }
    var toAddress: String { get }
    var ethValue: String { get }
    var txFee: String { get }
    var txStatus: Bool { get }
    var txStatusDisplay: String { get }
    var txStatusColor: UIColor { get }
    var txBgStatusColor: UIColor { get }
    var txType:String { get } // +  or -
    var txHash: String { get }
    var txGasUsed: String { get }
    var txGasPrice : String { get }
    var ethValueWithMarketPrice: String { get }
    var blockHeight : String { get }
}
