//
//  RoomTableViewCell.swift
//  RoomsFeature
//
//  Created by Daniel Bastidas Ramirez on 14/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    //MARK:- FONTSIZES
    let infoSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .subheadline).pointSize
    let textSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote).pointSize

    var roomCellViewModel : RoomCellViewModel? {
        didSet {
            roomName.text = roomCellViewModel?.roomName
            roomStatus.text = roomCellViewModel?.roomOccupied
            roomStatus.textColor = roomCellViewModel?.textColor
        }
     }
     
     private lazy var roomName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: infoSize)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
     }()
     
     private lazy var roomStatus : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: textSize)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
     }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.selectionStyle = .none
        
        let basicInformationStack = UIStackView(arrangedSubviews: [roomName,roomStatus])
        basicInformationStack.distribution = .fillEqually
        basicInformationStack.axis = .horizontal
        basicInformationStack.spacing = 10
        
        addSubview(basicInformationStack)
        basicInformationStack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
     
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

