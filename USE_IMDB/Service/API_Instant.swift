//
//  API_Instant.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation
import Alamofire

final class API_Instant: NSObject {
    private override init() { }
    
    static let shared = API_Instant()
    
    var dataRequest: DataRequest?
    
    class func search(text: String, success: ((SearchModel) -> Void)? = nil, failure: Failure? = nil) {
        self.requestInstant(params: ["s": text], success: success, failure: failure)
    }
    
    private class func requestInstant<T: Decodable>(params: JSON?, success: ((T) -> Void)? = nil, failure: Failure? = nil) {
        let link          = "https://movie-database-imdb-alternative.p.rapidapi.com/"
        let header        = API.getHeader()
        let parameters    = API.updateParameters(params)
        
        API.printLog("link", message: link)
        API.printLog("header", message: header.description)
        API.printLog("parameters", message: parameters.description)
        
        if let _dataRequest = API_Instant.shared.dataRequest {
            _dataRequest.cancel()
        }
        
        API_Instant.shared.dataRequest = Alamofire.SessionManager.default.request(link, method: .get, parameters: parameters, headers: header)
            .responseData { (response) in
                switch response.result {
                case .success(let result):
                    print(result)
                    do {
                        let model = try JSONDecoder().decode(T.self, from: result)
                        API.printLog("result", message: model)
                        success?(model)
                    } catch (let serializationError) {
                        API.printLog("error", message: serializationError)
                        failure?((serializationError as NSError).code, serializationError.localizedDescription)
                    }
                case .failure(URLError.cancelled):
                    break
                case .failure(let error):
                    API.printLog("error", message: error)
                    failure?((error as NSError).code, error.localizedDescription)
                }
        }
    }
}
