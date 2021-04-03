//
//  MenuDetailsScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
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
    
    private var menuItems: [MenuItem]

    var showLoader: Observable<Bool>
    let showLoaderRelay: PublishRelay<Bool> = PublishRelay<Bool>()

    init(router: StrongRouter<OrderRoute>,
         menuItems: [MenuItem]) {
        self.router = router
        self.menuItems = menuItems
        self.showLoader = self.showLoaderRelay.asObservable()
    }
}

extension OrderDetailsScreenViewModel: OrderDetailsScreenViewModelProtocol {
    func addButtonTapped(with indexPath: IndexPath, fail: @escaping Network.StatusBlock) {

    }
    
    func numberOfRows() -> Int {
        return menuItems.count
    }
    
    func item(at indexPath: IndexPath) -> MenuItem? {
        if menuItems.indices.contains(indexPath.row) {
            return menuItems[indexPath.row]
        }
        return nil
    }
}
