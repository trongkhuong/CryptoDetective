//
//  WalletAddressesViewModel.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/17/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
class WalletAddressesViewModel {
    
    var fetchDataCompletion:(() -> Void)?
    var symbol:String = "ETH"
    var eth: ETHWalletAddressesViewModel!
    var dataSource:Any!
    init(symbol:String, dataSource:Any, fetchDataCompletion:(() -> Void)?) {
        self.symbol = symbol
        self.dataSource = dataSource
        self.fetchDataCompletion = fetchDataCompletion
        initData()
    }
    func initData() {
        switch self.symbol {
        case CryptoListing.shared._Ethereum.symbol:
            eth = ETHWalletAddressesViewModel(address: dataSource as! [ETHWalletAddress])
            eth.fetchDataCompletion = fetchDataCompletion
            break
       
        default:
            break
        }
    }
    
    func getViewModel() -> WalletAddressProtocol {
        switch self.symbol {
        case  CryptoListing.shared._Ethereum.symbol:
            return eth
        default:
            return eth
        }
    }
    func getModel(at index:Int) -> BaseModel? {
        switch self.symbol {
        case  CryptoListing.shared._Ethereum.symbol:
            return eth.getWalletAddress(at: index)
        default:
            return nil
        }
    }
}
