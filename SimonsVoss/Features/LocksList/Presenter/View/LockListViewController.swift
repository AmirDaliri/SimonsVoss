//
//  LockListViewController.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import UIKit
import Combine

public class LockListViewController: UIViewController {
    private let viewModel: LockListViewModel

    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    lazy var searchBar:UISearchBar = UISearchBar()
    private var cancellable = Set<AnyCancellable>()

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

        setupUI()
        setupSearchBar()
        viewModel.onItemsLoad = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.loadItems()
        errorHandler()
    }

    private func setupUI() {
        tableView.register(LockItemTableViewCell.self)
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
        
    private func errorHandler() {
        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let weakSelf = self else { return }
                UIAlertController.error(message: errorMessage).present(on: weakSelf)
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Dismiss Keyboard
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
            searchBar.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
}

// MARK: - UISearchBarDelegate
extension LockListViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        self.viewModel.search(searchText: textSearched)
    }
}

// MARK: - UITableViewDataSource
extension LockListViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lockItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: LockItemTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let weakSelf = self else { return }
            cell.setText(lockItem: weakSelf.viewModel.lockItems[indexPath.row], searchString: weakSelf.searchBar.text ?? "")
        }
    }
}
