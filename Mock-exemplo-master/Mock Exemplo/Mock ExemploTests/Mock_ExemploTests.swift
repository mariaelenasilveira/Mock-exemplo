//
//  Mock_ExemploTests.swift
//  Mock ExemploTests
//
//  Created by Mariaelena Nascimento Silveira on 24/07/19.
//  Copyright © 2019 Mariaelena Nascimento Silveira. All rights reserved.
//

import XCTest
@testable import Mock_Exemplo

class Mock_ExemploTests: XCTestCase {
    var subject: HTTPClient!
    let session = MockURLSession()

    override func setUp() {
        super.setUp()
        
        subject = HTTPClient(session: session)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetRequest() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = ""
        components.path = ""
        
        let parametros = ["client_id":"xxxx","client_secret":"xxxx", "grant_type":"xxx"]
        components.queryItems = parametros.map{URLQueryItem(name: $0, value: $1)}
        
        // criando a url
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        
        // headers
        let headers = ["x-api-key":"xxxxxxxxxxxxxxxxxxxxx"]
        urlRequest.allHTTPHeaderFields = headers
        
        // method
        let method = "POST"
        urlRequest.httpMethod = method
        
        print("[URL] \(urlRequest)")
        
        subject.get(url: urlRequest, completion: {(_, _) in })
        
        XCTAssert(session.lastURL == urlRequest)
        
        session.dataTask(with: session.lastURL!, completionHandler: {(data, response, error) in
            print(data)
            guard let novaData = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                let dadoDecodificado = try decoder.decode(TokenModal.self, from: novaData)
                print(dadoDecodificado)
                
            } catch {
                print("não foi possivel decodificar")
            }
            
            
        })
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
