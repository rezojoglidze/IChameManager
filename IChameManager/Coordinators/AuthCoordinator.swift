//
//  AuthCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum AuthRoute: Route {
    case authScreen
    case mainTabbarScreen
    case alert(title: String, text: String, call: ((UIAlertAction) -> Void)? = nil)
}

class AuthCoordinator: NavigationCoordinator<AuthRoute> {
    static var shared: AuthCoordinator?
    
    init(rootController: UINavigationController, initialRoute: RouteType) {
        super.init(rootViewController: rootController, initialRoute: initialRoute)
        AuthCoordinator.shared = self
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .authScreen:
            let viewController = AuthorizationScreenViewController.instantiate(unownedRouter: self.unownedRouter)
            return .push(viewController)
        case .mainTabbarScreen:
            let tab = MainTabbarCoordinator()
            return .trigger(TabbarRoute.root, on: tab)
        case .alert(let title, let text, let call):
            let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
            let okAction =  UIAlertAction(title: "OK", style: .default, handler: call)
            alert.addAction(okAction)
            
            return .present(alert)
        }
    }
}
