//
//  DoorTableViewCell.swift
//  Test_4KSoft
//
//  Created by  Sasha Khomenko on 10.01.2023.
//

import UIKit
import SnapKit

enum Lock: String {
    case locked = "Locked"
    case unlocking = "Unlocking"
    case unlocked = "Unlocked"
}

class DoorTableViewCell: UITableViewCell {
    
    static let identifier = "DoorTableViewCell"
    private var lockState: Lock!
    
    private let loadIndicator = UIActivityIndicatorView()
    
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.2
        return view
    }()
    
    private let leftImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let rightImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Gill Sans", size: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Gill Sans Light", size: 14)
        return label
    }()
    
    private let lockLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Gill Sans", size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickDoor() {
        if lockState == .locked {
            lockState = .unlocking
            lockSetting(lock: lockState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.lockState = .unlocked
                self.lockSetting(lock: self.lockState)
            }
        } else if lockState == .unlocked {
            lockState = .unlocking
            lockSetting(lock: lockState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.lockState = .locked
                self.lockSetting(lock: self.lockState)
            }
        }
    }
    
    private func lockSetting(lock: Lock) {
        switch lock {
        case .locked:
            loadIndicator.stopAnimating()
            rightImage.alpha = 1
            lockLabel.text = Lock.locked.rawValue
            lockLabel.textColor = .black
            rightImage.image = UIImage(named: "LockedRight")
            leftImage.image = UIImage(named: "LockedLeft")
        case .unlocked:
            loadIndicator.stopAnimating()
            lockLabel.text = Lock.unlocked.rawValue
            rightImage.alpha = 1
            lockLabel.textColor = .black
            rightImage.image = UIImage(named: "UnlockedRight")
            leftImage.image = UIImage(named: "UnlockedLeft")
        case .unlocking:
            lockLabel.text = Lock.unlocking.rawValue
            lockLabel.textColor = .lightGray
            leftImage.image = UIImage(named: "Loading")
            rightImage.alpha = 0
            loadIndicator.startAnimating()
        }
    }
    
    func setupView(model: Door) {
        titleLabel.text =  model.title ?? ""
        descriptionLabel.text = model.description ?? ""
        leftImage.image = UIImage(named: model.leftImage ?? "")
        rightImage.image = UIImage(named: model.rightImage ?? "")
        if model.locked ?? true {
            lockLabel.text = Lock.locked.rawValue
            lockState = .locked
        } else {
            lockLabel.text = Lock.unlocked.rawValue
            lockState = .unlocked
        }
    }
    
    private func layout() {
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(15)
            $0.height.equalTo(117)
            $0.bottom.equalToSuperview().inset(14)
        }
        
        mainView.addSubview(leftImage)
        leftImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.left.equalToSuperview().offset(27)
        }
        
        mainView.addSubview(rightImage)
        rightImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.height.equalTo(45)
            $0.width.equalTo(41)
            $0.right.equalToSuperview().inset(28)
        }
        
        mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.left.equalTo(leftImage.snp.right).offset(14)
        }
        
        mainView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(leftImage.snp.right).offset(14)
        }
        
        mainView.addSubview(lockLabel)
        lockLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
        
        mainView.addSubview(loadIndicator)
        loadIndicator.snp.makeConstraints {
            $0.center.equalTo(rightImage)
            $0.height.width.equalTo(22)
        }
    }
}
