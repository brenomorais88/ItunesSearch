//
//  MusicDetailView.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation
import UIKit

//protocol MusicDetailViewProtocol {
//
//}

class MusicDetailView: UIView {
    lazy private var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let music: Musics
//    var delegate: MusicDetailViewProtocol? = nil
    
    init(music: Musics) {
        self.music = music
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.red
        self.viewCodeSetup()
    }
}

extension MusicDetailView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(messageLabel)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
}
