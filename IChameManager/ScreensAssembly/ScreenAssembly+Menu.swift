//
//  ScreenAssembly+Menu.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject
import XCoordinator

extension ScreensAssembly {
    func setupMenu() {
        setupMenuScreen()
        setupMenuDetailsScreen()
    }
    
    func setupMenuScreen() {
        self.container.register(OrderService.self) { (_) -> OrderService in
            return OrderService()
        }
        self.container.register(OrderScreenViewModel.self) { (resolver, router: StrongRouter<OrderRoute>) -> OrderScreenViewModel in
            let orderService = resolver.resolve(OrderService.self)
            let viewModel = OrderScreenViewModel(router: router, orderService: orderService)
            return viewModel
        }
        self.container.register(OrderScreenViewController.self) { (resolver, router: StrongRouter<OrderRoute>) -> OrderScreenViewController in
            let viewModel = resolver.resolve(OrderScreenViewModel.self, argument: router)
            let viewController = OrderScreenViewController.loadFromStoryboard()
            viewController.viewModel = viewModel
            return viewController
        }
    }
    
    func setupMenuDetailsScreen() {
        self.container.register(OrderDetailsScreenViewModel.self) { (resolver, router: StrongRouter<OrderRoute>, menuItems: [MenuItem]) -> OrderDetailsScreenViewModel in
            let viewModel = OrderDetailsScreenViewModel(router: router, menuItems: menuItems)
            return viewModel
        }
        self.container.register(OrderDetailsScreenViewController.self) { (resolver, router: StrongRouter<OrderRoute>, menuItems: [MenuItem], title: String) -> OrderDetailsScreenViewController in
            let viewModel = resolver.resolve(OrderDetailsScreenViewModel.self, arguments: router, menuItems)
            let viewController = OrderDetailsScreenViewController.loadFromStoryboard()
            viewController.viewModel = viewModel
            viewController.navigationTitle = title
            return viewController
        }
    }
}
