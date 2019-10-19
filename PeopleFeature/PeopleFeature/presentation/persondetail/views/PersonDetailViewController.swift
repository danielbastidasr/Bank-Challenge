//
//  PeopleDetailViewController.swift
//  PeopleFeature
//
//  Created by Daniel Bastidas Ramirez on 13/10/2019.
//  Copyright © 2019 Daniel Bastidas. All rights reserved.
//

import UIKit

class PersonDetailViewController: View {
    

    //MARK:- VIEW: TOP CONTAINER
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
       iv.image = #imageLiteral(resourceName: "first")
       iv.contentMode = .scaleAspectFill
       return iv
       
    }()
    let nameLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.font = UIFont.boldSystemFont(ofSize: 26)
       label.textColor = .white
       return label
    }()
    private let occupationLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.font = UIFont.systemFont(ofSize: 16)
       label.textColor = .white
       return label
    }()
    
    private lazy var topContainer: UIView = {
        let view = UIView()
        
        view.backgroundColor = .gray
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 120, height: 120, enableInsets: false)
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        view.addSubview(occupationLabel)
        occupationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        occupationLabel.anchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        return view
    }()
    
    //MARK:- VIEW: BOTTOM CONTAINER
    
    private var phone:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "123123123-123331.2312"
        return label
    }()
    private lazy var phoneStack:UIStackView  = {
        let phoneTitle = UILabel()
        phoneTitle.font = UIFont.boldSystemFont(ofSize: 14)
        phoneTitle.textColor = .black
        phoneTitle.text = "TELEPHONE NUMBER:"
        
        let view = UIStackView(arrangedSubviews: [phoneTitle,phone])
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    private var email:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "eafdfadfadfa@gadfadafad.com"
        return label
    }()
    private lazy var emailStack:UIStackView  = {
        let emailTitle = UILabel()
        
        emailTitle.font = UIFont.boldSystemFont(ofSize: 14)
        emailTitle.textColor = .black
        emailTitle.text = "EMAIL:"
        let view = UIStackView(arrangedSubviews: [emailTitle,email])
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var informationStack:UIStackView = {
        let infoStack = UIStackView(arrangedSubviews: [phoneStack,emailStack])
        infoStack.axis = .vertical
        infoStack.spacing = 15
        infoStack.distribution = .fillEqually
        return infoStack
    }()
    
    private lazy var bottomInformationView:UIView = {
        let view = UIView()
        view.addSubview(informationStack)
        informationStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        return view
    }()

    
    //MARK:- FULL VIEW CONTAINER
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.addSubview(topContainer)
        topContainer
            .anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: topViewHeight, enableInsets: false)
        
        view.addSubview(bottomInformationView)
        bottomInformationView
            .anchor(top: topContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:bottomViewHeight, enableInsets: false)

        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.addSubview(containerView)
        sv.contentSize.height = topViewHeight + bottomViewHeight
        sv.bounces = true
        sv.showsHorizontalScrollIndicator = true
        sv.isScrollEnabled = true
        return sv
    }()
    
    var personViewModel:PersonDetailViewModel?

    private let topViewHeight:CGFloat = 300
    private let bottomViewHeight:CGFloat = 200

   
    func resolveDI() {
        personViewModel = DIManager.resolvePersonDetailViewModel()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        containerView
            .anchor(top: scrollView.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    func bindData() {
        title = personViewModel?.personName
        nameLabel.text = personViewModel?.personName
        occupationLabel.text = personViewModel?.occupation
        topContainer.backgroundColor = personViewModel?.favColor
    }
}
