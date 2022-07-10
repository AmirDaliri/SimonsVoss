//
//  UIAlertController.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 11.07.2022.
//

import UIKit

extension UIAlertController {
    
    // MARK: - Alert Types
    static func alert(title: String = "", message: String = "") -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    static func sheet(title: String = "", message: String = "") -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    static func error(message: String = "") -> UIAlertController {
        return UIAlertController(title: "", message: message, preferredStyle: .alert).addOk()
    }
    
    // MAKR: - Tint
    func tint(_ color: UIColor) -> UIAlertController {
        view.tintColor = color
        return self
    }
    
    // MARK: - Basic Actions
    func addDefault(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }
    
    func addDestructive(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .destructive, handler: handler))
        return self
    }
    
    func addCancel(title: String? = "Cancel", handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: .cancel, handler: handler))
        return self
    }
    
    // MARK: - Other Actions
    func addOk(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        return self
    }
    
    // MARK: - Presentation
    // WARNING: This will crash on iPad if the alert type is sheet, still needs handling here
    func present(on presentingViewController: UIViewController) {
        presentingViewController.present(self, animated: true, completion: nil)
    }
}
