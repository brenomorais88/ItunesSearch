//
//  Coordinator.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import Foundation

protocol ViewCodeProtocol {
    func viewCodeSetup()
    func viewCodeHierarchySetup()
    func viewCodeConstraintSetup()
    func viewCodeAdditioalSetup()
}

extension ViewCodeProtocol {
    func viewCodeSetup() {
        self.viewCodeHierarchySetup()
        self.viewCodeConstraintSetup()
        self.viewCodeAdditioalSetup()
    }
    
    func viewCodeAdditioalSetup() {
        // optional method, used to do adtional settings
    }
}
