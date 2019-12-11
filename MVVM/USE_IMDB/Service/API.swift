//
//  API.swift
//  USE_IMDB
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation
import Alamofire

public typealias JSON = [String: Any]
public typealias FailureHandler = ((Int, String) -> Void)

// TODO: Definir criptografia da API

//enum APIType {
//    case dev
//    case prod
//
//    var path: String {
//        switch self {
//        case .dev:
//            return "https://movie-database-imdb-alternative.p.rapidapi.com/"
//        case .prod:
//            return "prod"
//        }
//    }
//}

class API {
    
    class func getMediaDetails(mediaId: String, success: ((MediaDetailsModel) -> Void)? = nil, failure: FailureHandler? = nil) {
        self.requestData(params: ["i": mediaId], success: success, failure: failure)
    }
    
    class func search(text: String, success: ((SearchModel) -> Void)? = nil, failure: FailureHandler? = nil) {
        self.requestData(params: ["s": text], success: success, failure: failure)
    }
    
    internal class func requestData<T: Decodable>(params: JSON?, success: ((T) -> Void)? = nil, failure: FailureHandler? = nil) {
        // TODO: Atualizar requisição (remover Alamofire)
        
        let baseLink = "https://movie-database-imdb-alternative.p.rapidapi.com/"
        let header = self.getHeader()
        let parameters = self.updateParameters(params)
        
        self.printLog("link", message: baseLink)
        self.printLog("header", message: header)
        self.printLog("parameters", message: parameters)
        Alamofire.request(baseLink, method: .get, parameters: parameters, headers: header).responseData { (response) in
            switch response.result {
            case .success(let result):
                print(result)
                do {
                    let model = try JSONDecoder().decode(T.self, from: result)
                    printLog("result", message: model)
                    success?(model)
                } catch (let serializationError) {
                    printLog("error", message: serializationError)
                    failure?((serializationError as NSError).code, serializationError.localizedDescription)
                }
            case .failure(let error):
                printLog("error", message: error)
                failure?((error as NSError).code, error.localizedDescription)
            }
        }
    }
    
    class func printLog(_ type: String, message: Any) {
        #if DEBUG
            print("##\(type.uppercased()) - \(message)")
        #endif
    }
    
    class func getHeader() -> [String: String] {
        let header: [String: String] = ["X-RapidAPI-Host": "movie-database-imdb-alternative.p.rapidapi.com",
                            "X-RapidAPI-Key" : "a6956ef93cmsh6ec36f446c3058ap143917jsn6d29c3c1006e"]
        return header
    }
    
    class func updateParameters(_ params: JSON?, page: Int = 1) -> JSON {
        var parameters: JSON = params ?? JSON()
        parameters["r"] = "json"
        parameters["page"] = page
        return parameters
    }
    
    
}
