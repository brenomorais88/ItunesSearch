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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var music: Musics?
    
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
        self.image.imageFromURL(urlString: music?.imgURL ?? "")
        self.titleLabel.text = music?.collectionName ?? ""
        self.viewCodeSetup()
    }
}

extension MusicDetailView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(image)
        self.addSubview(titleLabel)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.defaultMargin),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.defaultMargin),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize100),
            image.widthAnchor.constraint(equalToConstant: Constants.imageSize100),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.defaultMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.defaultMargin)
        ]
        NSLayoutConstraint.activate(constants)
    }
}
