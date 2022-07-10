//
//  LockListViewController.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import UIKit

public class LockListViewController: UIViewController {

    private let viewModel: LockListViewModel

    // MARK: - Initializer
    public init(viewModel: LockListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LockListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
