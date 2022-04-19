//
//  WalletAddressRepresentable.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/17/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
protocol WalletAddressRepresentable {
    var walletAlias:String { get set}
    var addressDisplay:String { get }
    var amount:String { get }
    var value:String { get } // value in usd
    
}
