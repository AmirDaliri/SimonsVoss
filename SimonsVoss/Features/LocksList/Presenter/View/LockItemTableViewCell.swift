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
