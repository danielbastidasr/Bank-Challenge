//
//  RoomDetailViewController.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class RoomDetailViewController: View {

    private let infoSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).pointSize
    private var roomViewModel:RoomDetailViewModel?
    
    private lazy var roomName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: infoSize)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    func resolveDI() {
        roomViewModel = DIManager.resolveRoomDetailVieModel()
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(roomName)
        roomName.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
    
    func bindData() {
        title = "\(roomViewModel?.roomName ?? "Detailed") room"
        roomName.textColor = roomViewModel?.textColor
        roomName.text = roomViewModel?.roomDetail
    }
}
