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
    
    func loadOrders(success: @escaping (Order?) -> Void,
                    fail: @escaping Network.StatusBlock) {
        db.collection(Constants.bucketiOS).whereField("restaurantId", isEqualTo: "qM46LjeUVons6c27owM8")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        let result = Result {
                            try document.data(as: Order.self)
                        }
                        switch result {
                        case .success(let order):
                            success(order)
                        case .failure(let error):
                            fail(error)
                        }
                    }
                }
            }
    }
}
