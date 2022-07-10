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
    
    // MARK: - Setup View
    func setText(lockItem: LockItem, searchString: String) {
        if let boldedAddress = boldedString(with: lockItem.name,
                                            searchString: searchString,
                                            fontSize: lockNameLabel.font.pointSize) {
            lockNameLabel.attributedText = boldedAddress
        } else {
            lockNameLabel.text = lockItem.name
        }
        
        
        if let boldedAddress = boldedString(with: lockItem.buildingShortcut,
                                            searchString: searchString,
                                            fontSize: lockNameLabel.font.pointSize) {
            buildingShortCutLabel.attributedText = boldedAddress
        } else {
            buildingShortCutLabel.text = lockItem.buildingShortcut
        }

        
        if let boldedAddress = boldedString(with: lockItem.floor,
                                            searchString: searchString,
                                            fontSize: lockNameLabel.font.pointSize) {
            floorLabel.attributedText = boldedAddress
        } else {
            floorLabel.text = lockItem.floor
        }

        
        if let boldedAddress = boldedString(with: lockItem.roomNo,
                                            searchString: searchString,
                                            fontSize: lockNameLabel.font.pointSize) {
            roomNumberLabel.attributedText = boldedAddress
        } else {
            roomNumberLabel.text = lockItem.roomNo
        }
    }
}

// MARK: - Helpers
private extension LockItemTableViewCell {
    
    private func boldedString(with baseString: String, searchString: String, fontSize: CGFloat) -> NSAttributedString? {
      guard let regex = try? NSRegularExpression(pattern: searchString, options: .caseInsensitive) else {
          return nil
      }

      let attributedString = NSMutableAttributedString(string: baseString)
      let boldFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
      regex
        .matches(in: baseString, options: .withTransparentBounds,
                 range: NSRange(location: 0, length: baseString.utf16.count))
        .forEach {
          attributedString.addAttributes([.font: boldFont], range: $0.range)
      }
      return attributedString
    }
}
