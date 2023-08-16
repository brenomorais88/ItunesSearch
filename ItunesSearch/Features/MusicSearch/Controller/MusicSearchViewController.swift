//
//  MusicDetailsViewController.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import UIKit

class MusicSearchViewController: UIViewController {
    let viewModel: MusicSearchViewModel?
    private var currentView: UIView?
    
    private let searchTextField: UISearchTextField = {
        let view = UISearchTextField()
        view.placeholder = Strings.kArtistName.rawValue
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var errorView: UIView?
    private var resultsView: UIView?
    private var loadingView: UIView?
    
    init(viewModel: MusicSearchViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewCodeSetup()
        self.title = Strings.kSearchViewTitle.rawValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadListener()
        self.viewModel?.loadData()
    }
    
    private func loadListener() {
        viewModel?.viewState.bind({ [weak self] viewState in
            guard let viewState = viewState else {
                return
            }
            
            DispatchQueue.main.async {
                switch viewState {
                case .Loading:
                    self?.setupLoadingView()
                case .Empty:
                    self?.setupEmptyView()
                case .Error:
                    self?.setupErrorView()
                case .Data:
                    self?.setupResultsView()
                }
            }
        })
    }
    
    private func setupLoadingView() {
        self.cleanViews()
        let view = LoadingView()
        self.contentView.addSubview(view)
        self.loadingView = view
    }
    
    private func setupResultsView() {
        self.cleanViews()
        let resultsView = UIView()
        self.contentView.addSubview(resultsView)
        self.resultsView = resultsView
    }
    
    private func setupEmptyView() {
        self.cleanViews()
        let errorView = ErrorView(error: Strings.kNoResultsMessage.rawValue)
        errorView.delegate = self
        self.contentView.addSubview(errorView)
        self.errorView = errorView
    }
    
    private func setupErrorView() {
        self.cleanViews()
        let errorView = ErrorView(error: Strings.kErrorMessage.rawValue)
        errorView.delegate = self
        self.contentView.addSubview(errorView)
        self.errorView = errorView
    }
    
    private func cleanViews() {
        self.loadingView?.removeFromSuperview()
        self.resultsView?.removeFromSuperview()
        self.errorView?.removeFromSuperview()
    }
}

extension MusicSearchViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.view.addSubview(searchTextField)
        self.view.addSubview(contentView)
    }
    
    func viewCodeConstraintSetup() {
        
    }
}

extension MusicSearchViewController: ErrorViewProtocol {
    func tryAgain() {
        self.viewModel?.loadData()
    }
}
