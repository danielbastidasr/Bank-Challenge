//
//  PersonTableViewCell.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 14/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PersonTableViewCell: UITableViewCell {
    
    //MARK:- FONTSIZES
    let infoSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .subheadline).pointSize
    let textSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote).pointSize

    var personCellViewModel : PersonCellViewModel? {
        didSet {
            personName.text = personCellViewModel?.fullName
            jobTitle.text = personCellViewModel?.jobTitle
            personCellViewModel?.image
                .subscribeOn(MainScheduler.instance)
                .bind(to: personImage.rx.image)
            .disposed(by: disposableBag)
        
            personCellViewModel?.getImage()
        }
     }
    
     private lazy var personName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: infoSize)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
     
     }()
     
     private lazy var jobTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: textSize)
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
    
    private var disposableBag = DisposeBag()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.isAccessibilityElement = true
        self.accessibilityTraits = .button
        self.selectionStyle = .none
        
        let basicInformationStack = UIStackView(arrangedSubviews: [personName, jobTitle])
        basicInformationStack.distribution = .fillProportionally
        basicInformationStack.axis = .vertical
        
        let personInfo = UIStackView(arrangedSubviews: [personImage, basicInformationStack])
        personInfo.distribution = .fillProportionally
        personInfo.axis = .horizontal
        personInfo.spacing = 20
        
        addSubview(personInfo)
        
        personImage.anchor(
            top: personInfo.topAnchor,
            left: personInfo.leftAnchor,
            bottom: personInfo.bottomAnchor,
            right: nil,
            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 0,
            enableInsets: false
        )
        personInfo.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
        personInfo.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0,
            enableInsets: false
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposableBag = DisposeBag()
        personCellViewModel = nil
        personName.text = nil
        jobTitle.text = nil
        personImage.image = nil
    }
}

