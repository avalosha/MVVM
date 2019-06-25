//
//  ViewController.swift
//  MVVM
//
//  Created by Álvaro Ávalos Hernández on 6/25/19.
//  Copyright © 2019 Álvaro Ávalos Hernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: BoundTextField!
    
    var user = User(name: Observable("Alvaro Avalos"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameTextField.bind(to: user.name)
        /*
        //Actualiza el nombre de usuario modelo
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.user.name.value = "Bilbo Baggins"
        }
 */
    }


}

class BoundTextField: UITextField {
    
    //Se llama cuando editingChanged suceda
    var changedClosure: (() -> ())?
    
    
    @objc func valueChanged() {
        changedClosure?()
    }
    
    func bind(to observable: Observable<String>) {
        
        addTarget(self, action: #selector(BoundTextField.valueChanged), for: .editingChanged)
        
        changedClosure = {[weak self] in
            observable.bindingChanged(to: self?.text ?? "")
        }
        
        observable.valueChanged = {[weak self] newValue in
            self?.text = newValue
        }
    }
    
}

