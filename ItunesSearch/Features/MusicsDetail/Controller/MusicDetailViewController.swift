//
//  MusicDetailViewController.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import UIKit

class MusicDetailViewController: UIViewController {
    let viewModel: MusicDetailViewModelProtocol
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let musicDetailsView: MusicDetailView = {
        let view = MusicDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: MusicDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.kDetailsViewTitle.rawValue
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewCodeSetup()
        self.loadListener()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.showDetails()
    }
    
    private func loadListener() {
        viewModel.viewState.bind({ [weak self] viewState in
            guard let viewState = viewState else {
                return
            }
            
            DispatchQueue.main.async {
                switch viewState {
                case .Data(let music):
                    self?.setupDetailsView(music: music)
                }
            }
        })
    }
    
    private func setupDetailsView(music: Musics) {
        self.musicDetailsView.setupView(music: music)
    }
}

extension MusicDetailViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.view.addSubview(musicDetailsView)
    }
    
    func viewCodeConstraintSetup() {
        let layoutGuide = self.view.safeAreaLayoutGuide
        let constants = [
            musicDetailsView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            musicDetailsView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            musicDetailsView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            musicDetailsView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
}
