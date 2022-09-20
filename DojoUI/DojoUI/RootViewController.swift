//
//  RootViewController.swift
//  DojoUI
//
//  Created by Alexis Charytonow on 9/20/22.
//

import UIKit


protocol MyUIDelegate: AnyObject {
    func tapMeAction(myUIView: MyUIView, message: String)
}

class MyUIView: UIView {
    var textField: UITextField!
    var button: UIButton!
    
    weak var delegate: MyUIDelegate?
    
    init(frame: CGRect, delegate: MyUIDelegate?) {
        self.delegate = delegate
        
        super.init(frame: frame)
        let safeArea = self.safeAreaLayoutGuide
        
        // UITextField
        textField = UITextField()
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12.0).isActive = true
        textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12.0).isActive = true
        textField.borderStyle = .line
        
        // UIButton
        button = UIButton()
        button.setTitle("Tap Me!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(bridgeButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyUIView {
    @objc private func bridgeButtonAction() {
        delegate?.tapMeAction(myUIView: self, message: self.textField.text ?? "")
    }
}

class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        var topUIFrame = view.frame
        topUIFrame.origin.y -= 50
        let topUI = MyUIView(frame: topUIFrame, delegate: self)
        view.addSubview(topUI)
        
        var bottomUIFrame = view.frame
        bottomUIFrame.origin.y += 50
        let bottomUI = MyUIView(frame: bottomUIFrame, delegate: self)
        view.addSubview(bottomUI)
    }
}

extension RootViewController: MyUIDelegate {
    @objc func tapMeAction(myUIView: MyUIView, message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
