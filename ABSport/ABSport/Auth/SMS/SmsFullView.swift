//
//  SmsFullView.swift
//  ABSport
//
//  Created by Егор Иванов on 13.03.2024.
//

import UIKit

final class SmsFullView: UIView {
    
    var onBackButtonTapped: (() -> Void)? {
        get { smsView.onBackButtonTap }
        set { smsView.onBackButtonTap = newValue }
    }
    
    // MARK: - private properties
    private enum Const {
        static let cornerRadiusView: CGFloat = 48
    }
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let smsView = SmsView()
    
    private let loadScreenImageView = UIImageView()
    
    private lazy var smsViewBottomConstraint = smsView.bottomAnchor.constraint(equalTo: bottomAnchor)
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubAndTransOff()
        setupView()
        layoutObjects()
        setupRegistationView()
        setImage()
        setupObserveKeyboard()

    }
    
    // MARK: - private methods
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "LoadColor")
    }
    private func setupObserveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setImage() {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: UIImage(named: "LogoImage")!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(6, forKey: kCIInputRadiusKey)

        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        loadScreenImageView.image = processedImage
    }
    private func setupRegistationView() {
        smsView.layer.cornerRadius = Const.cornerRadiusView
        smsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func addSubAndTransOff() {
        [loadScreenImageView, smsView].forEach({ element in
            addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    @objc private func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        smsViewBottomConstraint.constant = -(keyboardSize?.height ?? 250)
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide(notification: Notification) {
        smsViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    // MARK: - layout
    private func layoutObjects() {
        NSLayoutConstraint.activate([
            loadScreenImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadScreenImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            loadScreenImageView.heightAnchor.constraint(equalToConstant: 210),
            loadScreenImageView.widthAnchor.constraint(equalToConstant: 210),
            
            smsView.heightAnchor.constraint(equalToConstant: 494),
            smsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            smsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            smsViewBottomConstraint
        ])
    }
}
