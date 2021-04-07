//
//  OrderScreenViewControlle.swift
//  IChameManager
//
//  Created by Rezo Joglidze on 4/7/21.
//

import UIKit
import XCoordinator
import RxSwift

class OrderScreenViewController: UIViewController {
    
    var viewModel: OrderScreenViewModelProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()

    static func instantiate(strongRouter: StrongRouter<OrderRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoader()
        setupTableView()
        setupNavigationBar()
        viewModel.loadOrders(fail: self.standardFailBlock)
        setupObservables()
    }
    
    private func setupObservables() {
        viewModel.ordersDidLoad.subscribe(onNext: { [weak self] _ in
           self?.stopLoader()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
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
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderScreenTableViewCell.self)) as! OrderScreenTableViewCell
        if let item = viewModel.item(at: indexPath) {
            cell.fill(img: UIImage(named: "coldDishes_icon"), title: item.restaurantId)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.setSelected(false, animated: true)
        viewModel.openMenuDetails(with: indexPath)
    }
}
