//
//  Menu.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/17/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation

struct Order: Decodable {
    var hotDishes : [String : MenuItem]?
    var coldDishes : [String : MenuItem]?
    var drinks : [String : MenuItem]?
    var sauces : [String : MenuItem]?
    var restaurantId: String
}

struct MenuItem: Codable {
    var id: String
    var description: String
    var name: String
    var price: Double
    var count: Int
    var type: MenuType
}

enum MenuType: String, Codable {
    case hotDishes
    case coldDishes
    case drinks
    case sauces
    
    var title: String {
        switch self {
        case .hotDishes:
            return "ცხელი კერძები"
        case .coldDishes:
            return "ცივი კერძები"
        case .drinks:
            return "სასმელები"
        case .sauces:
            return "სოუსები"
        }
    }
}
