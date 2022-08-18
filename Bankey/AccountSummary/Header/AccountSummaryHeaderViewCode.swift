//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Karina on 19/06/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    let shakeyBellView: ShakeyBell = {
        let shakeyBellView = ShakeyBell()
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        return shakeyBellView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = appColor
        return contentView
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 4
        stack.distribution = .fill
        return stack
    }()
    
    let dataStack: UIStackView = {
        let dataStack = UIStackView()
        dataStack.translatesAutoresizingMaskIntoConstraints = false
        dataStack.axis = .vertical
        dataStack.alignment = .leading
        dataStack.spacing = 8
        dataStack.distribution = .fill
        return dataStack
    }()
    
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Bankey"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let greetingLabel: UILabel = {
        let greetingLabel = UILabel()
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.text = "Good Morning"
        greetingLabel.font = UIFont.systemFont(ofSize: 17)
        return greetingLabel
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Karina"
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        return nameLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "Date"
        dateLabel.font = UIFont.systemFont(ofSize: 17)
        return dateLabel
    }()
    
    let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.image = UIImage(systemName: "sun.max.fill")
        weatherImage.tintColor = .systemYellow
        weatherImage.clipsToBounds = true
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.setContentHuggingPriority(.defaultHigh, for: .vertical)
        weatherImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return weatherImage
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func setUp() {
        addSubview(contentView)
        contentView.addSubview(stack)
        stack.addArrangedSubview(dataStack)
        dataStack.addArrangedSubview(titleLabel)
        dataStack.addArrangedSubview(greetingLabel)
        dataStack.addArrangedSubview(nameLabel)
        dataStack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(weatherImage)
        addSubview(shakeyBellView)
        
        let myconstraint = stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        myconstraint.priority = .defaultLow
        myconstraint.isActive = true
        
        let newconstraint = stack.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 2)
        newconstraint.priority = .defaultLow
        myconstraint.isActive = true
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            weatherImage.heightAnchor.constraint(equalToConstant: 100),
            weatherImage.widthAnchor.constraint(equalToConstant: 100),
            
            
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            shakeyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
