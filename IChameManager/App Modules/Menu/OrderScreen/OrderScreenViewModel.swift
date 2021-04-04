//
//  HomeScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol OrderScreenViewModelProtocol {
    var router: StrongRouter<OrderRoute> { get }
    
    func item(at indexPath: IndexPath) -> (type: MenuType, img: UIImage?)?
    
    func openMenuDetails(with indexPath: IndexPath)
    
    func loadOrders(fail: @escaping Network.StatusBlock)
}

class OrderScreenViewModel {
    var router: StrongRouter<OrderRoute>
    
    var orders: Order?
    var orderService: OrderService?
    
    init(router: StrongRouter<OrderRoute>,
         orderService: OrderService?) {
        self.router = router
        self.orderService = orderService
    }
}

extension OrderScreenViewModel: OrderScreenViewModelProtocol {
    func loadOrders(fail: @escaping Network.StatusBlock) {
        orderService?.loadOrders(success: {[weak self] (orders) in
            self?.orders = orders
            print("orderss ->", orders)
        }, fail: fail)
    }
    
    func openMenuDetails(with indexPath: IndexPath) {
        
    }
    
    func item(at indexPath: IndexPath) -> (type: MenuType, img: UIImage?)? {
        return nil
    }
}
