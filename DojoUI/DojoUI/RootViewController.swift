//
//  RootViewController.swift
//  DojoUI
//
//  Created by Alexis Charytonow on 9/20/22.
//

import UIKit

class MyUIView: UIView {
    var textField: UITextField!
    var button: UIButton!
    
    override init(frame: CGRect) {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        let myUIView = MyUIView(frame: view.frame)
        view.addSubview(myUIView)
    }

}

