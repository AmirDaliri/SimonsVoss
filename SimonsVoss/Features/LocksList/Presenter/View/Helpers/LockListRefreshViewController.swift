//
//  LockListRefreshViewController.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 11.07.2022.
//

import UIKit
import Combine

public final class LockListRefreshViewController: NSObject {
    private(set) lazy var view = binded(UIRefreshControl())
    
    private let viewModel: LockListViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: LockListViewModel) {
        self.viewModel = viewModel
    }
        
    @objc func refresh() {
        viewModel.loadItems()
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onLoadingStateChange
        /// for passing test
        //  .receive(on: DispatchQueue.main)
            .sink { [view] isLoading in
                if isLoading {
                    view.beginRefreshing()
                } else {
                    view.endRefreshing()
                }
            }
            .store(in: &cancellable)
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}

