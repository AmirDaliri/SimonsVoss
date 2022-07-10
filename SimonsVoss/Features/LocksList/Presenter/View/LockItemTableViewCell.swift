//
//  LockItemTableViewCell.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import UIKit

class LockItemTableViewCell: UITableViewCell {

    // MARK: - @IBOutlet
    @IBOutlet private weak var lockNameLabel: UILabel!
    @IBOutlet private weak var buildingShortCutLabel: UILabel!
    @IBOutlet private weak var floorLabel: UILabel!
    @IBOutlet private weak var roomNumberLabel: UILabel!
    
    // MARK: - initialize
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
