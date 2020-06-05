//
//  TokenModal.swift
//  MesaVirtual
//
//  Created by Mariaelena Silveira on 09/04/2019.
//  Copyright © 2019 Mariaelena Silveira. All rights reserved.
//

import Foundation

struct TokenModal: Codable {
    let token: String
    let refreshToken: String?
    let expiresIn: Int32
    let scope: String?
    
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope
    }
}
