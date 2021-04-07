//
//  HomeCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum OrderRoute: Route {
    case order
    case orderDetails(order: Order)
}

class OrderCoordinator: NavigationCoordinator<OrderRoute> {
    static let shared = OrderCoordinator()
    
    init() {
        super.init(rootViewController: UINavigationController(), initialRoute: .order)
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .order:
            let menu = OrderScreenViewController.instantiate(strongRouter: self.strongRouter)
            return .push(menu)
        case .orderDetails(let order):
            let menuDetails = OrderDetailsScreenViewController.instantiate(strongRouter: self.strongRouter, order: order)
            return .push(menuDetails)
        }
    }
}
