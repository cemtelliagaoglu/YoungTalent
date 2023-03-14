//
//  CommunityHeader.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import UIKit

class CommunityHeader: UICollectionReusableView {
    //MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Community"
        label.font = UIFont(name: "Montserrat-Semibold", size: 14)
        label.textColor = UIColor(named: "Blue-Dark")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(named: "Blue-Dark")
        button.heightAnchor.constraint(equalToConstant: 13).isActive = true
        button.widthAnchor.constraint(equalToConstant: 13).isActive = true
        button.addTarget(self, action: #selector(handleMoreButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(named: "Blue-Dark")
        button.heightAnchor.constraint(equalToConstant: 13).isActive = true
        button.widthAnchor.constraint(equalToConstant: 13).isActive = true
        button.addTarget(self, action: #selector(handleBackButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel, moreButton])
        backButton.isHidden = true
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Handlers
    @objc func handleMoreButtonPressed(){
        print("More Groups Button Pressed...")
    }
    
    @objc func handleBackButtonPressed(){
        print("Back Button Pressed...")
    }
    
    func setupView(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
