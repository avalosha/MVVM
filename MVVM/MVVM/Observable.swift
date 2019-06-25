//
//  Observable.swift
//  MVVM
//
//  Created by Álvaro Ávalos Hernández on 6/25/19.
//  Copyright © 2019 Álvaro Ávalos Hernández. All rights reserved.
//

import Foundation

class Observable<ObservedType> {
    
    private var _value: ObservedType?
    
    init(_ value: ObservedType) {
        _value = value
    }
    
    //Envía el valor actual a los que sea que lo esté viendo
    var valueChanged: ((ObservedType?) -> ())?
    
    //Manipula el valor almacenado de forma segura
    public var value: ObservedType? {
        get {
            return _value
        }
        set {
            _value = newValue
            valueChanged?(_value)
        }
    }
    
    func bindingChanged(to newValue: ObservedType) {
        _value = newValue
        print("Value is now \(newValue)")
    }
}
