//
//  BaseTableViewViewModelProtocol.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/23/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
public protocol BaseTableViewViewModelProtocol {
    associatedtype T
    var fetchDataCompletion:(() -> Void)? {get set}
    var hasData:Bool {get}
    var noDataMessage:String {get set}
    var availableFetchData:Bool {get set}
    var numberOfSection:Int {get}
    var request:T {get set}
    func numberOfRowInSection(section:Int) -> Int
    func fetchData()
}
