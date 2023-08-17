//
//  MusicDetailView.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation
import UIKit

class MusicDetailView: UIView {
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 18.0)
        view.textColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var musicDetailsTable: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(MusicDetailCell.self,
                      forCellReuseIdentifier: MusicDetailCell.cellID)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private var music: Musics?
    private var cellBuilders: [MusicDetailCellBuilder] = []
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(music: Musics) {
        self.music = music
        self.setupView()
    }
    
    private func setupView() {
        self.titleLabel.text = music?.collectionName ?? ""
        self.image.imageFromURL(urlString: music?.imgURL ?? "")
        self.loadCellBuilders()
        self.viewCodeSetup()
    }
    
    private func loadCellBuilders() {
        if let artist = self.music?.artistName {
            self.cellBuilders.append(MusicDetailCellBuilder(title: "Artist", value: artist, type: .defaultValue))
        }
        
        if let collection = self.music?.collectionName {
            self.cellBuilders.append(MusicDetailCellBuilder(title: "Collection", value: collection, type: .defaultValue))
        }
        
        if let coutry = self.music?.country {
            self.cellBuilders.append(MusicDetailCellBuilder(title: "Country", value: coutry, type: .defaultValue))
        }
        
        if let genre = self.music?.primaryGenreName {
            self.cellBuilders.append(MusicDetailCellBuilder(title: "Genre", value: genre, type: .defaultValue))
        }
        
        if let price = self.music?.getFormattedValue() {
            self.cellBuilders.append(MusicDetailCellBuilder(title: "Price", value: price, type: .moneyValue))
        }
        
        self.musicDetailsTable.reloadData()
    }
}

extension MusicDetailView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(image)
        self.addSubview(titleLabel)
        self.addSubview(musicDetailsTable)
    }
    
    func viewCodeConstraintSetup() {
        let constants: [NSLayoutConstraint] = [
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.bigMargin),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize100),
            image.widthAnchor.constraint(equalToConstant: Constants.imageSize100),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.bigMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.defaultMargin),
            
            musicDetailsTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.bigMargin),
            musicDetailsTable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            musicDetailsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicDetailsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
}

extension MusicDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellBuilders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let builder = self.cellBuilders[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: MusicDetailCell.cellID,
                                                    for: indexPath) as? MusicDetailCell {
            cell.setup(builder: builder)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
