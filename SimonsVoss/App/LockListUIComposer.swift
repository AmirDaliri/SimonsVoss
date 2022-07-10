//
//  LockListUIComposer.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import UIKit

public final class LockListUIComposer {
    private init() {}
    
    public static func composedWith(loader: DataLoader) -> LockListViewController {
        let viewModel = LockListViewModel(loader: loader)
        let refreshController = LockListRefreshViewController(viewModel: viewModel)
        let vc = LockListViewController(viewModel: viewModel, refreshController: refreshController)
        return vc
    }
}
