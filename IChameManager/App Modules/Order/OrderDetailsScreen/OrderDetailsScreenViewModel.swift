//
//  dd.swift
//  IChameManager
//
//  Created by Rezo Joglidze on 4/7/21.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol OrderDetailsScreenViewModelProtocol {
    var router: StrongRouter<OrderRoute> { get }
    var showLoader: Observable<Bool> { get }

    func numberOfRows() -> Int
    
    func item(at indexPath: IndexPath) -> MenuItem?
    
    func addButtonTapped(with indexPath: IndexPath, fail: @escaping Network.StatusBlock)
}

class OrderDetailsScreenViewModel {
    
    var router: StrongRouter<OrderRoute>
    
    private var order: Order

    var showLoader: Observable<Bool>
    let showLoaderRelay: PublishRelay<Bool> = PublishRelay<Bool>()

    init(router: StrongRouter<OrderRoute>,
         order: Order) {
        self.router = router
        self.order = order
        self.showLoader = self.showLoaderRelay.asObservable()
    }
}

extension OrderDetailsScreenViewModel: OrderDetailsScreenViewModelProtocol {
    func addButtonTapped(with indexPath: IndexPath, fail: @escaping Network.StatusBlock) {

    }
    
    func numberOfRows() -> Int {
        return 3
    }
    
    func item(at indexPath: IndexPath) -> MenuItem? {
        return nil
    }
}
