//
//  TableHeaderView.swift
//  Test_4KSoft
//
//  Created by  Sasha Khomenko on 10.01.2023.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeaderView"
    
    let mainView = UIView()
    
    let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HeaderHome")
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Welcome"
        label.font = UIFont(name: "Gill Sans Bold", size: 35)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview()
            $0.height.equalTo(250)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        mainView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.left.equalToSuperview()
        }
        
        mainView.addSubview(headerImage)
        headerImage.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(168)
            $0.width.equalTo(189)
            $0.top.equalToSuperview().offset(20)
        }
    }
}
