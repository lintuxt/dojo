//
//  RootViewController.swift
//  DojoUI
//
//  Created by Alexis Charytonow on 9/20/22.
//

import UIKit

class MyUIView: UIViewController {
    var textField: UITextField!
    var button: UIButton!
    
    override func viewDidLoad() {
        let safeArea = view.safeAreaLayoutGuide
        
        // UITextField
        textField = UITextField()
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        textField.borderStyle = .line
        
        // UIButton
        button = UIButton()
        button.setTitle("Tap Me!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
}


class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        let myUIView = MyUIView()
        view.addSubview(myUIView.view)
    }


}

