//
//  MusicsCell.swift
//  ItunesSearch
//
//  Created by Breno Morais on 16/08/23.
//

import UIKit

class MusicsCell: UITableViewCell {
    static let cellID = "MusicsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "MusicsCell")
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.selectionStyle = .none
        self.viewCodeSetup()
    }
    
    func setup(music: Musics) {
        print(music)
    }
}

extension MusicsCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        
    }
    
    func viewCodeConstraintSetup() {
        
    }
}
