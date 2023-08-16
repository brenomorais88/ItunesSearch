//
//  LoadingView.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation
import UIKit

class LoadingView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.kLoagindMsg.rawValue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView() {
        self.viewCodeSetup()
    }
}

extension LoadingView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(messageLabel)
        self.addSubview(loading)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: loading.bottomAnchor,
                                              constant: Constants.defaultMargin)
        ]
        NSLayoutConstraint.activate(constants)
    }
    
    func viewCodeAdditioalSetup() {
        self.loading.startAnimating()
    }
}

