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
}

class OrderScreenViewModel {
    var router: StrongRouter<OrderRoute>
    
    var menu: Menu?
    
    init(router: StrongRouter<OrderRoute>) {
        self.router = router
    }
}

extension OrderScreenViewModel: OrderScreenViewModelProtocol {
    func openMenuDetails(with indexPath: IndexPath) {
        
    }
    
    func item(at indexPath: IndexPath) -> (type: MenuType, img: UIImage?)? {
        return menu?.menuScreenDataSource[indexPath.row]
    }
}
