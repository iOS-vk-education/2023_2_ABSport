//
//  LoginView.swift
//  ABSport
//
//  Created by Егор Иванов on 28.03.2024.
//

import UIKit

final class LoginView: UIView {
    
    var onLoginButtonTap: (() -> Void)?
    var onSubmitButtonTap: (() -> Void)?
    var onBackButtonTap: (() -> Void)?
    
    // MARK: - private properties
    private var agreeOrDisagree: Bool = false
    
    private enum Const {
        static let topTitleConst: CGFloat = 32
    }
    
    private lazy var enterStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.addArrangedSubview(enterButton)
        
        return stack
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(named: "BlueButtonColor")
        button.setTitle("<", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private let title: UILabel = {
        let text = UILabel()
        let viewWidth = UIScreen.main.bounds.width
        let ratio = viewWidth / 393
        text.font = UIFont.systemFont(ofSize: CGFloat(26 * ratio), weight: .semibold)
        text.textColor = .black
        text.text = "Вход"
        text.textAlignment = .left
        return text
    }()
    
    let numberField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "DarkGreyColor")
        textField.layer.cornerRadius = 15
        textField.placeholder = "+7 777 777 77 77"
        textField.keyboardType = .numberPad
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        return textField
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "DarkGreyColor")
        textField.placeholder = "**********"
        textField.layer.cornerRadius = 15
        textField.keyboardType = .default
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        return textField
    }()
    
    let passwordText: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Пароль"
        text.font = UIFont.systemFont(ofSize: 16)
        
        return text
    }()
    
    let textNumberField: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Логин / номер телефона"
        text.font = UIFont.systemFont(ofSize: 16)
        
        return text
    }()
    private let smsButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Войти", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(named: "BlueButtonColor")
        
        return button
    }()
    
    private let agreeWithPersonalDataText: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 15)
        text.text = "Запомнить меня"
        text.textAlignment = .center
        return text
    }()
    
    private let agreeWithDataButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor(named: "DarkGreyColor")
        button.layer.borderWidth = 1
        
        return button
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.underline("Забыли пароль?", offset: 2)
        return button
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubAndTransOff()
        setupView()
        layoutObjects()
        setupTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    private func setupView() {
        backgroundColor = .white
        numberField.delegate = self
        
        smsButton.addTarget(self, action: #selector(submitButtonDidTap), for: .touchUpInside)
        agreeWithDataButton.addTarget(self, action: #selector(agreeWithDataButtonTapped), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func addSubAndTransOff() {
        [title, numberField, textNumberField, smsButton, agreeWithPersonalDataText, agreeWithDataButton, enterStack, passwordField, passwordText, backButton].forEach({ element in
            addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func submitButtonDidTap() {
        onSubmitButtonTap?()
    }
    
    @objc func handleTap() {
        numberField.resignFirstResponder()
    }
    
    @objc func agreeWithDataButtonTapped() {
        agreeOrDisagree.toggle()
        agreeWithDataButton.backgroundColor = agreeOrDisagree ? UIColor(named: "BlueButtonColor") : UIColor(named: "DarkGreyColor")
    }
    
    @objc func enterButtonTapped() {
        onLoginButtonTap?()
    }
    
    @objc func backButtonTapped() {
        onBackButtonTap?()
    }
    // MARK: - layout
    
    private func layoutObjects() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: Const.topTitleConst),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Const.topTitleConst),
            backButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            
            textNumberField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 83),
            textNumberField.bottomAnchor.constraint(equalTo: numberField.topAnchor),
            textNumberField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            textNumberField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            numberField.topAnchor.constraint(equalTo: textNumberField.bottomAnchor, constant: 4),
            numberField.heightAnchor.constraint(equalToConstant: 40),
            numberField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            numberField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            passwordText.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 20),
            passwordText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            passwordText.bottomAnchor.constraint(equalTo: passwordField.topAnchor),
            
            passwordField.topAnchor.constraint(equalTo: passwordText.bottomAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            passwordField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            smsButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            smsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            smsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            smsButton.heightAnchor.constraint(equalToConstant: 40),
            
            agreeWithDataButton.topAnchor.constraint(equalTo: smsButton.bottomAnchor, constant: 26),
            agreeWithDataButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            agreeWithDataButton.heightAnchor.constraint(equalToConstant: 20),
            agreeWithDataButton.widthAnchor.constraint(equalToConstant: 20),
            
            agreeWithPersonalDataText.centerYAnchor.constraint(equalTo: agreeWithDataButton.centerYAnchor),
            agreeWithPersonalDataText.leadingAnchor.constraint(equalTo: agreeWithDataButton.trailingAnchor, constant: 12),
        
            enterStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            enterStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string != "+" {
            textField.text = "+7" + string
            return false
        }
        guard let text = textField.text, let range = Range(range, in: text) else { return false }
        let newString = text.replacingCharacters(in: range, with: string)
        textField.text = newString.formatPhoneNumber(with: "+X (XXX) XXX-XXXX", phone: newString)
        
        return false
    }
}

