//
//  SmsView.swift
//  ABSport
//
//  Created by Егор Иванов on 13.03.2024.
//

import UIKit

final class SmsView: UIView {
    
    var onLoginButtonTap: (() -> Void)?
    var onSubmitButtonTap: (() -> Void)?
    var onBackButtonTap: (() -> Void)?
    
    // MARK: - private properties
    private var agreeOrDisagree: Bool = false
    
    private enum Const {
        static let topTitleConst: CGFloat = 32
    }
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(named: "BlueButtonColor")
        button.setTitle("<", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private lazy var enterStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.addArrangedSubview(enterText)
        stack.addArrangedSubview(enterButton)
        
        return stack
    }()
    
    private let title: UILabel = {
        let text = UILabel()
        let viewWidth = UIScreen.main.bounds.width
        let ratio = viewWidth / 393
        text.font = UIFont.systemFont(ofSize: CGFloat(26 * ratio), weight: .semibold)
        text.textColor = .black
        text.text = "Вход"
        text.textAlignment = .center
        return text
    }()
    
    let numberField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "DarkGreyColor")
        textField.layer.cornerRadius = 15
        textField.keyboardType = .numberPad
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        return textField
    }()
    
    let textNumberField: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Номер телефона"
        text.font = UIFont.systemFont(ofSize: 16)
        
        return text
    }()
    
    private let smsButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Вход", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(named: "BlueButtonColor")
        
        return button
    }()
    
    private let agreeWithPersonalDataText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "DarkGreyColor")
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Я даю согласие на обработку "
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
    private let personalDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "DarkGreyColor")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("персональных данных", for: .normal)
        button.titleLabel?.underline("персональных данных", offset: 2)
        return button
    }()
    
    private let enterText: UILabel = {
        let text = UILabel()
        text.text = "Уже есть аккаунт? "
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 15)
        
        return text
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.underline("Войти", offset: 2)
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
        
        smsButton.addTarget(self, action: #selector(submitButtonDidTap), for: .touchUpInside)
        agreeWithDataButton.addTarget(self, action: #selector(agreeWithDataButtonTapped), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func addSubAndTransOff() {
        [title, numberField, textNumberField, smsButton, agreeWithPersonalDataText, agreeWithDataButton, personalDataButton, enterStack, backButton].forEach({ element in
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
            textNumberField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            textNumberField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            numberField.topAnchor.constraint(equalTo: textNumberField.bottomAnchor, constant: 4),
            numberField.heightAnchor.constraint(equalToConstant: 40),
            numberField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            numberField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            smsButton.topAnchor.constraint(equalTo: numberField.bottomAnchor, constant: 20),
            smsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            smsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            smsButton.heightAnchor.constraint(equalToConstant: 40),
            
            agreeWithDataButton.topAnchor.constraint(equalTo: smsButton.bottomAnchor, constant: 26),
            agreeWithDataButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            agreeWithDataButton.heightAnchor.constraint(equalToConstant: 20),
            agreeWithDataButton.widthAnchor.constraint(equalToConstant: 20),
            
            agreeWithPersonalDataText.centerYAnchor.constraint(equalTo: agreeWithDataButton.centerYAnchor),
            agreeWithPersonalDataText.leadingAnchor.constraint(equalTo: agreeWithDataButton.trailingAnchor, constant: 3),
            
            personalDataButton.centerYAnchor.constraint(equalTo: agreeWithPersonalDataText.centerYAnchor, constant: 1),
            personalDataButton.leadingAnchor.constraint(equalTo: agreeWithPersonalDataText.trailingAnchor),
            personalDataButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            enterStack.topAnchor.constraint(equalTo: agreeWithDataButton.bottomAnchor, constant: 120),
            enterStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            enterStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

