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
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var priceLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = UIColor.appGreen
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
        self.detailLabel.text = ""
        self.priceLabel.text = ""
    }
    
    private func initialSetup() {
        self.selectionStyle = .none
        self.viewCodeSetup()
    }
    
    func setup(music: Musics) {
        self.image.imageFromURL(urlString: music.imgURL ?? "")
        self.titleLabel.text = music.trackName ?? music.collectionName ?? ""
        self.detailLabel.text = music.artistName
        self.priceLabel.text = music.getFormattedValue()
    }
}

extension MusicsCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(image)
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(priceLabel)
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
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.defaultMargin),
            
            detailLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.defaultMargin),
            detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.midleMargin),
            
            priceLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.defaultMargin),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            priceLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
}
