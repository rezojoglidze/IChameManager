//
//  AuthorizationScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol AuthorizationScreenViewModelProtocol {
    var router: UnownedRouter<AuthRoute> { get }
    
    var userDidLogin: Observable<Void> { get }
    var showLoader: Observable<Bool> { get }
    
    func authorization(email: String, password: String, fail: @escaping Network.StatusBlock)
    
    func triggerAuthorizationCompletion()
}

class AuthorizationScreenViewModel {
    var router: UnownedRouter<AuthRoute>
    var userService: UserService?
    
    let userDidLogin: Observable<Void>
    let showLoader: Observable<Bool>
    let innerUserDidLogin: PublishRelay<Void> = PublishRelay<Void>()
    let innerShowLoader: PublishRelay<Bool> = PublishRelay<Bool>()
    
    init(router: UnownedRouter<AuthRoute>, userService: UserService?) {
        self.router = router
        self.userService = userService
        self.userDidLogin = self.innerUserDidLogin.asObservable()
        self.showLoader = self.innerShowLoader.asObservable()
    }
}

extension AuthorizationScreenViewModel: AuthorizationScreenViewModelProtocol {
    func triggerAuthorizationCompletion() {
        router.trigger(.mainTabbarScreen)
    }
    
    func authorization(email: String, password: String, fail: @escaping Network.StatusBlock) {
        userService?.authorization(email: email, password: password, success: { [weak self] (user) in
            guard let user = user else {
                self?.innerShowLoader.accept(false)
                self?.router.trigger(.alert(title: "დაფიქსირდა შეცდომა!", text: "მსგავსი მონაცემებით იუზერი არ არსებობს"))
                return
            }
            User.current = user
            self?.innerUserDidLogin.accept(())
        }, fail: fail)
    }
}
