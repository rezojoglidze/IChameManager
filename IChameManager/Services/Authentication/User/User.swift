//
//  User.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/14/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

struct User: Codable {
    static var current: User?
    
    var email: String
    var password: String
    var restaurantId: String
}
