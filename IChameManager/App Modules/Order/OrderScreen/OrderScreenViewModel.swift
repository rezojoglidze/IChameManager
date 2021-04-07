//
//  Orderie.swift
//  IChameManager
//
//  Created by Rezo Joglidze on 4/7/21.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol OrderScreenViewModelProtocol {
    var router: StrongRouter<OrderRoute> { get }
    var ordersDidLoad: Observable<Void> { get }
    func item(at indexPath: IndexPath) -> Order?
    
    func openMenuDetails(with indexPath: IndexPath)
    
    func loadOrders(fail: @escaping Network.StatusBlock)
    
    func numberOfRowsInSection() -> Int
}

class OrderScreenViewModel {
    var router: StrongRouter<OrderRoute>
    
    var orders: [Order] = []
    var orderService: OrderService?

    let ordersDidLoad: Observable<Void>
    let ordersRelayDidLoad: PublishRelay<Void> = PublishRelay<Void>()

    
    init(router: StrongRouter<OrderRoute>,
         orderService: OrderService?) {
        self.router = router
        self.orderService = orderService
        self.ordersDidLoad = ordersRelayDidLoad.asObservable()
    }
}

extension OrderScreenViewModel: OrderScreenViewModelProtocol {
    func numberOfRowsInSection() -> Int {
        return orders.count
    }
    
    func loadOrders(fail: @escaping Network.StatusBlock) {
        orderService?.loadOrders(success: {[weak self] (orders) in
            self?.orders = orders
            self?.ordersRelayDidLoad.accept(())
        }, fail: fail)
    }
    
    func openMenuDetails(with indexPath: IndexPath) {
        router.trigger(.orderDetails(order: orders[indexPath.row]))
    }
    
    func item(at indexPath: IndexPath) -> Order? {
        return orders[indexPath.row]
    }
}
