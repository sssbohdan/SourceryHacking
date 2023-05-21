//
//  DependancyWrapper.swift
//  SourceryHacking
//
//  Created by Bohdan Savych on 21/05/2023.
//

import Foundation

@propertyWrapper struct DependancyWrapper<T: Service> {
    var wrappedValue: T {
        mutating get {
            if _value == nil {
                _value = T.init()
            }

            return _value!
        }
    }

    var _value: T?
}
