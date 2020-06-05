//
//  HTTPClient.swift
//  Mock Exemplo
//
//  Created by Mariaelena Nascimento Silveira on 24/07/19.
//  Copyright © 2019 Mariaelena Nascimento Silveira. All rights reserved.
//

import Foundation


protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

typealias HTTPResult = (Data?, Error?) -> Void

class HTTPClient {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(url: URLRequest, completion: @escaping HTTPResult) {
        session.dataTask(with: url, completionHandler: {(data, _, _) in
            print(data)
        })
    }
}

extension URLSession: URLSessionProtocol { }


class MockURLSession: URLSessionProtocol {
    
    private (set) var lastURL: URLRequest?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = request
        
        let json: [String: Any] = ["access_token": "",
            "token_type": "bearer",
            "expires_in": 7743291,
            "scope": ""]
        
        let jsonData = try? JSONSerialization.data(withJSONObject:json)
        print(jsonData)
        completionHandler(jsonData, nil, nil)

        return URLSessionDataTask()
    }
    
}
