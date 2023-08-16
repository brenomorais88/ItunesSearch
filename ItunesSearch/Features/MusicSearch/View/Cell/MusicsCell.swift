//
//  MusicsCell.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import UIKit

class MusicsCell: UITableViewCell {
    static let cellID = "MusicsCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "MusicsCell")
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.image.image = UIImage()
        self.titleLabel.text = ""
    }
    
    private func initialSetup() {
        self.selectionStyle = .none
        self.viewCodeSetup()
    }
    
    func setup(music: Musics) {
        self.image.imageFromURL(urlString: music.imgURL ?? "")
        self.titleLabel.text = music.collectionName ?? ""
    }
}

extension MusicsCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(image)
        self.addSubview(titleLabel)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.defaultMargin),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.defaultMargin),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.defaultNegativeMargin),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize100),
            image.widthAnchor.constraint(equalToConstant: Constants.imageSize100),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.defaultMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.defaultMargin)
        ]
        NSLayoutConstraint.activate(constants)
    }
}
