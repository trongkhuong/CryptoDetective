//
//  Network.swift
//  KhuongCointCalcu
//
//  Created by Tran Khuong on 7/3/18.
//  Copyright © 2018 Tran Khuong. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
open class Network {
    public static let shared: Network = Network()
    private init() {}

    func sendRequestWithResponseObj<T: Mappable>(requestUrl:String,completion:@escaping (_ result:DataResponse<T>) -> ()) {
        Alamofire.request(requestUrl).responseObject { (response:DataResponse<T>) in
            completion(response)
        }
    }
    //T:ResponseMarketData
    func sendRequestMarketData(requestData:[String:String],completion:@escaping (_ result:ResponseRawObject?) -> ()) {
        let fsyms = requestData[ValuesUtils.shared.marketFromSymbol]!
        let tsyms = requestData[ValuesUtils.shared.marketToSymbol]!
        let requestUrl = String(format: APIURL.shared.MarketURLString,fsyms,tsyms)
        Alamofire.request(requestUrl).responseObject { (response:DataResponse<ResponseMarketData>) in
            guard let data = response.result.value else {
                completion(nil)
                return
            }
            var khuongtlt:ResponseRawObject?
            if let map = data.rawObject?.map, let new = ResponseRawObject(JSON: map.JSON) {
                new.initMoreData(fromSyms: fsyms, toSyms: tsyms)
                new.mapping(map: new.map!)
                khuongtlt = new
            }
            completion(khuongtlt)
        }
    }
}
