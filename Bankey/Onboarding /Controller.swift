//
//  Controller.swift
//  Bankey
//
//  Created by Karina on 24/05/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}


class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let heroImageName: String
    let titleLabel: String
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(heroImageName: String, titleLabel: String) {
        self.heroImageName = heroImageName
        self.titleLabel = titleLabel
        
        super.init(nibName: nil, bundle: nil)
    

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ViewController {
    func style() {
        
        view.backgroundColor = .systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: heroImageName)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.text = titleLabel
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
            
            
            
        ])
    }
}




