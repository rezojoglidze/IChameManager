//
//  UserService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/13/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Network {
    typealias StatusBlock = ((_ error: Error?) -> Void)
}

class UserService {
    lazy private var db = Firestore.firestore()
    
    func authorization(email: String,
                       password: String,
                       success: @escaping(User?) -> Void,
                       fail: @escaping Network.StatusBlock) {
        db.collection(Constants.managers).whereField("email", isEqualTo: "\(email)")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: User.self)
                        }
                        switch result {
                        case .success(let user):
                            success(user)
                        case .failure(let error):
                            fail(error)
                        }
                    }
                    success(nil)
                }
            }
    }
}
