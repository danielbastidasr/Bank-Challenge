//
//  PersonTableViewCell.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 14/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    var personCellViewModel : PersonCellViewModel? {
        didSet {
            personName.text = personCellViewModel?.fullName
            jobTitle.text = personCellViewModel?.jobTitle
        }
     }
     
     private let personName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
     
     }()
     
     private let jobTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
     }()
    
    
    private let personImage : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .black
        img.image = UIImage()
        return img
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let basicInformationStack = UIStackView(arrangedSubviews: [personName, jobTitle])
        basicInformationStack.distribution = .fillEqually
        basicInformationStack.axis = .vertical
        basicInformationStack.spacing = 20
    
        let personInfo = UIStackView(arrangedSubviews: [personImage, basicInformationStack])
        personInfo.distribution = .fillProportionally
        personInfo.axis = .horizontal
        personInfo.spacing = 20
        
        addSubview(personInfo)
        
        personImage.anchor(top: personInfo.topAnchor, left: personInfo.leftAnchor, bottom: personInfo.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 0, enableInsets: false)
        
        personInfo.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

