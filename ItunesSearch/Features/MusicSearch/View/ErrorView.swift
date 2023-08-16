//
//  ErrorView.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation
import UIKit

protocol ErrorViewProtocol {
    func tryAgain()
}

class ErrorView: UIView {
    lazy private var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var tryAgainButton: FirstButton = {
        let button = FirstButton(text: Strings.kTryAgain.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let error: String
    var delegate: ErrorViewProtocol? = nil
    
    init(error: String) {
        self.error = error
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white
        self.viewCodeSetup()
    }
    
    @objc private func tryAgain() {
        self.delegate?.tryAgain()
    }
}

extension ErrorView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(messageLabel)
        self.addSubview(tryAgainButton)
    }
    
    func viewCodeConstraintSetup() {
        let constants = [
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tryAgainButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                    constant: Constants.defaultMargin),
            tryAgainButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                     constant: Constants.defaultNegativeMargin),
            tryAgainButton.heightAnchor.constraint(equalToConstant: Constants.defaultButtonHeight),
            tryAgainButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constants)
    }
    
    func viewCodeAdditioalSetup() {
        self.tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        self.messageLabel.text = self.error
    }
}

