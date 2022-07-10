//
//  LockListViewController.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import UIKit

public class LockListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

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

// MARK: - UITableViewDataSource
extension LockListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
