//
//  HomeViewRepresentable.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 1/8/19.
//  Copyright © 2019 Tran Khuong. All rights reserved.
//

import Foundation
import UIKit
public protocol MarketDataRepresentable {
    var imgBgUrl:String? { get }
    var title:String { get }
    var imgLogoUrl:String { get }
    var detail:String { get }
    var marketPrice:String { get }
    var marketPrice24h:String { get }
    var price24hColor:UIColor { get }
    var low24hPrice:String { get }
    var high24hPrice:String { get }
    var marketCap:String { get }
    var volumn24h:String { get }
    var widgetTitle:String { get }
    var widgetMarketPrice24h:String { get }
    
}
