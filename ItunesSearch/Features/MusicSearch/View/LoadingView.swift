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
        return label
    }()
    
    private let loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.startAnimating()
        return loading
    }()
    
    init() {
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
}

extension LoadingView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(messageLabel)
        self.addSubview(loading)
    }
    
    func viewCodeConstraintSetup() {
    }
    
    func viewCodeAdditioalSetup() {
        self.loading.startAnimating()
    }
}

