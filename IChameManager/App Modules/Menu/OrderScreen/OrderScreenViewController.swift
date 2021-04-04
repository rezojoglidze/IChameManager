//
//  OrderScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class OrderScreenViewController: UIViewController {
    
    var viewModel: OrderScreenViewModelProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    static func instantiate(strongRouter: StrongRouter<OrderRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        viewModel.loadOrders(fail: self.standardFailBlock)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "შეკვეთები"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: OrderScreenTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OrderScreenTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension OrderScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderScreenTableViewCell.self)) as! OrderScreenTableViewCell
        if let item = viewModel.item(at: indexPath) {
            cell.fill(img: item.img, title: item.type.title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.setSelected(false, animated: true)
        viewModel.openMenuDetails(with: indexPath)
    }
}
