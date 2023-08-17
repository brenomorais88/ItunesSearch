//
//  MusicDetailCell.swift
//  ItunesSearch
//
//  Created by Breno Morais on 17/08/23.
//

import UIKit

enum MusicDetailBuilderType {
    case defaultValue
    case moneyValue
}

struct MusicDetailCellBuilder {
    let title: String
    let value: String
    let type: MusicDetailBuilderType
}

class MusicDetailCell: UITableViewCell {
    static let cellID = "MusicDetailCell"
    
    lazy private var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.darkGray
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont.boldSystemFont(ofSize: 16)
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
        self.titleLabel.text = ""
        self.detailLabel.text = ""
    }
    
    private func initialSetup() {
        self.selectionStyle = .none
        self.viewCodeSetup()
    }
    
    func setup(builder: MusicDetailCellBuilder) {
        self.titleLabel.text = builder.title
        self.detailLabel.text = builder.value
        
        switch builder.type {
        case .moneyValue:
            self.detailLabel.textColor = .appGreen
        case .defaultValue:
            self.detailLabel.textColor = .black
        }
    }
}

extension MusicDetailCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.defaultMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.defaultMargin),
            
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.defaultMargin),
            detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.defaultNegativeMargin),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.midleMargin)
        ]
        NSLayoutConstraint.activate(constants)
    }
}
