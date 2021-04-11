//
//  ScannerService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/17/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class OrderService {
    
    lazy private var db = Firestore.firestore()
    
    func loadOrders(success: @escaping ([Order]) -> Void,
                    fail: @escaping Network.StatusBlock) {
        db.collection(Constants.orderiOS).whereField("restaurantId", isEqualTo: User.current?.restaurantId)
            .getDocuments() { (querySnapshot, err) in
                var orders: [Order] = []
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: Order.self)
                        }
                        switch result {
                        case .success(let order):
                            if let order = order {
                                orders.append(order)
                            }
                        case .failure(let error):
                            fail(error)
                        }
                    }
                    success(orders)
                }
            }
    }
}
