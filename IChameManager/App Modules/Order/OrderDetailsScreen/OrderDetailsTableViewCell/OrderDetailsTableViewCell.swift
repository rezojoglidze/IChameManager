//
//  MenuDetailsTableViewCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/20/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

protocol OrderDetailsTableViewCellDelegate: class {
    func didTapActionButton(cell: OrderDetailsTableViewCell, isAdd: Bool)
}

class OrderDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var menuItemImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    @IBOutlet private weak var removeBtn: UIButton!
    @IBOutlet private weak var addBtn: UIButton!
    weak var delegate: OrderDetailsTableViewCellDelegate?
    var indexPath: IndexPath?
    var type: MenuType?
    
    func fill(item: MenuItem) {
        self.titleLbl.text = item.name
        self.descriptionLbl.text = item.description
        self.priceLbl.text = "\(item.price) ₾"
    }
    
    @IBAction func actionBtnTapped(_ sender: UIButton!) {
        delegate?.didTapActionButton(cell: self, isAdd: true)
    }
    
    @IBAction func removeBtnTapped(_ sender: Any) {
        delegate?.didTapActionButton(cell: self, isAdd: false)
    }
}
