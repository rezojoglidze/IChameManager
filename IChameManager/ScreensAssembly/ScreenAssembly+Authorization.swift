//
//  ScreenAssembly+Authorization.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject
import XCoordinator

extension ScreensAssembly {
    
    func setupAuthorization() {
        setupSplashScreen()
        setupAuthorizationScreen()
    }
    
    private func setupSplashScreen() {
        self.container.register(SplashScreenViewController.self) { (resolver, router: UnownedRouter<MainRoute>) -> SplashScreenViewController in
            let viewModel = resolver.resolve(SplashScreenViewModel.self, argument: router)
            let viewController = SplashScreenViewController.loadFromStoryboard()
            viewController.viewModel = viewModel
            return viewController
        }
        
        self.container.register(SplashScreenViewModel.self) { (_, router: UnownedRouter<MainRoute>) -> SplashScreenViewModel in
            let viewModel = SplashScreenViewModel(router: router)
            return viewModel
        }
    }
    
    private func setupAuthorizationScreen() {
        self.container.register(UserService.self) { (_) -> UserService in
            return UserService()
        }
        self.container.register(AuthorizationScreenViewModel.self) { (resolver, router: UnownedRouter<AuthRoute>) -> AuthorizationScreenViewModel in
            let userService = resolver.resolve(UserService.self)
            let viewModel = AuthorizationScreenViewModel(router: router, userService: userService)
            return viewModel
        }
        self.container.register(AuthorizationScreenViewController.self) { (resolver, router: UnownedRouter<AuthRoute>) -> AuthorizationScreenViewController in
            let viewModel = resolver.resolve(AuthorizationScreenViewModel.self, argument: router)
            let viewController = AuthorizationScreenViewController.loadFromStoryboard()
            viewController.viewModel = viewModel
            return viewController
        }
    }
}
