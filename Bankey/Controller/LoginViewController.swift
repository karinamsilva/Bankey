//
//  ViewController.swift
//  Bankey
//
//  Created by Karina on 09/05/22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}


class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorLabel = UILabel()
    weak var delegate: LoginViewControllerDelegate?
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    var userName: String? {
        return loginView.userNameTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

}

extension LoginViewController {
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.leadingAnchor, multiplier: 1),
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.leadingAnchor, multiplier: 1),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            
        ])
    }
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.text = "Bankey"
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        subtitleLabel.textAlignment = .center
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
    
    extension LoginViewController {
        @objc func signInTapped(sender: UIButton) {
            errorLabel.isHidden = true
            login()
        }
    
    private func login() {
        guard let userName = userName, let password = password else {
            assertionFailure("UserName/Password should never be blank")
            return 
        }
        
        if userName.isEmpty || password.isEmpty {
            configureView(withMessage: "username/password cannot be blank")
            return
        }
        if userName == "Karina" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
            signInButton.setTitle("Signing In", for: .normal)
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorret username/password")
        }
    }
    
    func configureView(withMessage message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}


