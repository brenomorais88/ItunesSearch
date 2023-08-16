//
//  MusicDetailViewController.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import UIKit

class MusicDetailViewController: UIViewController {
    let viewModel: MusicDetailViewModelProtocol
    private var musicDetailsView: MusicDetailView?
    
    init(viewModel: MusicDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("dealoc: MusicDetailViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.kDetailsViewTitle.rawValue
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        musicDetailsView = MusicDetailView(music: music)
        self.view = musicDetailsView
    }
}
