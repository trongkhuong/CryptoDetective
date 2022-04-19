//
//  WalletAddressProtocol.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/18/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
protocol WalletAddressProtocol {
    var fetchDataCompletion:(() -> Void)? {get set}
    var hasData:Bool {get}
    var noTransactionMessage:String {get set}
    var availableFetchData:Bool {get set}
    var numberOfSection:Int {get}
    func numberOfRowInSection(section:Int) -> Int
    func fetchData()
    func getInfoByIndex(indexPath:IndexPath) -> WalletAddressRepresentable?
    //func getWalletInfo(indexPath:IndexPath)
}
