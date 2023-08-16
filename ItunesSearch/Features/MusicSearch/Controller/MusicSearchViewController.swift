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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
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
        self.view = contentView
        self.title = Strings.kSearchViewTitle.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewCodeSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadListener()
        self.viewModel?.loadData(term: "Eminem")
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
                case .Data(let musics):
                    self?.setupResultsView(musics: musics)
                }
            }
        })
    }
    
    private func setupLoadingView() {
        self.cleanViews()
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        self.loadingView = view
        setupViewConstants(view: view)
    }
    
    private func setupResultsView(musics: [Musics]) {
        self.cleanViews()
        let resultsView = MusicsView(musics: musics)
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(resultsView)
        self.resultsView = resultsView
        setupViewConstants(view: resultsView)
    }
    
    private func setupEmptyView() {
        self.cleanViews()
        let errorView = ErrorView(error: Strings.kNoResultsMessage.rawValue)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.delegate = self
        self.contentView.addSubview(errorView)
        self.errorView = errorView
        setupViewConstants(view: errorView)
    }
    
    private func setupErrorView() {
        self.cleanViews()
        let errorView = ErrorView(error: Strings.kErrorMessage.rawValue)
        errorView.delegate = self
        errorView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(errorView)
        self.errorView = errorView
        setupViewConstants(view: errorView)
    }
    
    private func cleanViews() {
        self.loadingView?.removeFromSuperview()
        self.resultsView?.removeFromSuperview()
        self.errorView?.removeFromSuperview()
    }
    
    private func setupViewConstants(view: UIView) {
        let layoutGuide = self.contentView.safeAreaLayoutGuide
        let constants = [
            view.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor,
                                      constant: Constants.defaultMargin),
            view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
}

extension MusicSearchViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.contentView.addSubview(searchTextField)
    }
    
    func viewCodeConstraintSetup() {
        let layoutGuide = self.contentView.safeAreaLayoutGuide
        let constants = [
            searchTextField.topAnchor.constraint(equalTo: layoutGuide.topAnchor,
                                                 constant: Constants.defaultMargin),
            searchTextField.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor,
                                                     constant: Constants.defaultMargin),
            searchTextField.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor,
                                                      constant: Constants.defaultNegativeMargin),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.searchTextHeight)
        ]
        NSLayoutConstraint.activate(constants)
    }
}

extension MusicSearchViewController: ErrorViewProtocol {
    func tryAgain() {
        self.viewModel?.loadData(term: "Eminem")
    }
}
