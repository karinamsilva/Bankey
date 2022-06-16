//
//  LoginView.swift
//  Bankey
//
//  Created by Karina on 09/05/22.
//

import UIKit

class LoginView: UIView {
    
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView =  UIView()
    
    let stackview = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LoginView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "Username"
        userNameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 8
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true 
        
    }
    
    func layout() {
        stackview.addArrangedSubview(userNameTextField)
        stackview.addArrangedSubview(dividerView)
        stackview.addArrangedSubview(passwordTextField)
        self.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            stackview.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackview.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackview.bottomAnchor, multiplier: 1)
        ])
        
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
    }
}
