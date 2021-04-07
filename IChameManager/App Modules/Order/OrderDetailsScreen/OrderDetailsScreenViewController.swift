//
//  ddViewController.swift
//  IChameManager
//
//  Created by Rezo Joglidze on 4/7/21.
//

import UIKit
import XCoordinator
import RxSwift

class OrderDetailsScreenViewController: UIViewController {
    
    var viewModel: OrderDetailsScreenViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()

    static func instantiate(strongRouter: StrongRouter<OrderRoute>, order: Order) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, arguments: strongRouter, order) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupObservables()
    }
    
    private func setupObservables() {
        viewModel.showLoader.subscribe(onNext: { [weak self] show in
            show ? self?.startLoader() : self?.stopLoader()
        }).disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "navigationTitle"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: OrderDetailsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OrderDetailsTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: MenuDetailsTableViewCellDelegate
extension OrderDetailsScreenViewController: OrderDetailsTableViewCellDelegate {
    func didTapActionButton(cell: OrderDetailsTableViewCell, isAdd: Bool) {
        guard let indexPath = cell.indexPath else { return }

        viewModel.addButtonTapped(with: indexPath, fail: self.standardFailBlock)
    }
}

//MARK: tableView UITableViewDataSource & UITableViewDelegate
extension OrderDetailsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderDetailsTableViewCell.self)) as! OrderDetailsTableViewCell
        if let item = viewModel.item(at: indexPath) {
            cell.fill(item: item)
            cell.delegate = self
            cell.indexPath = indexPath
        }
        return cell
    }
}
