//
//  RootViewController.swift
//  DojoUI
//
//  Created by Alexis Charytonow on 9/20/22.
//

import UIKit


protocol MyUIDelegate: AnyObject {
    func tapMeAction(_ sender: MyUIView, message: String)
}

class MyUIView: UIView {
    var textField: UITextField!
    var button: UIButton!
    
    public var identifier: String?
    public weak var delegate: MyUIDelegate?
    
    var componentHeight: CGFloat {
        return textField.intrinsicContentSize.height + button.intrinsicContentSize.height + 12
    }
    
    init() {
        self.identifier = nil
        self.delegate = nil

        super.init(frame: CGRect.zero)

        // UITextField
        textField = UITextField()
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.0).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0).isActive = true
        textField.borderStyle = .line
        
        // UIButton
        button = UIButton()
        button.setTitle("Tap Me!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(bridgeButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyUIView {
    @objc private func bridgeButtonAction() {
        delegate?.tapMeAction(self, message: self.textField.text ?? "")
    }
}

class RootViewController: UIViewController {
    
    var textField: UITextField!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .gray
        
        let safeArea = view.safeAreaLayoutGuide
        
        let topUI = MyUIView()
        topUI.identifier = "topUI"
        topUI.delegate = self
        view.addSubview(topUI)
        topUI.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topUI.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            topUI.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -topUI.componentHeight / 2),
            topUI.heightAnchor.constraint(equalToConstant: topUI.componentHeight),
            topUI.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            topUI.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        let bottomUI = MyUIView()
        bottomUI.identifier = "bottomUI"
        bottomUI.delegate = self
        view.addSubview(bottomUI)
        bottomUI.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomUI.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            bottomUI.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: bottomUI.componentHeight / 2),
            bottomUI.heightAnchor.constraint(equalToConstant: topUI.componentHeight),
            bottomUI.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            bottomUI.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RootViewController: MyUIDelegate {
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func tapMeAction(_ sender: MyUIView, message: String) {
        if sender.identifier == "topUI" {
            alert(title: "Top", message: message)
        } else if sender.identifier == "bottomUI" {
            alert(title: "Bottom", message: message)
        }
    }
}
