//
//  MusicsView.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation
import UIKit

protocol MusicsViewProtocol {
    func showDetail(music: Musics)
}

class MusicsView: UIView {
    
    lazy private var musicsTable: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MusicsCell.self,
                      forCellReuseIdentifier: MusicsCell.cellID)
        return view
    }()
    
    let musics: [Musics]
    var delegate: MusicsViewProtocol? = nil
    
    init(musics: [Musics]) {
        self.musics = musics
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white
        self.viewCodeSetup()
        self.musicsTable.reloadData()
    }
}

extension MusicsView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(musicsTable)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            musicsTable.topAnchor.constraint(equalTo: self.topAnchor),
            musicsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            musicsTable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            musicsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
}

extension MusicsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let music = self.musics[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: MusicsCell.cellID,
                                                    for: indexPath) as? MusicsCell {
            cell.setup(music: music)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let music = self.musics[indexPath.row]
        self.delegate?.showDetail(music: music)
    }
}
