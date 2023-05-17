//
//  Service.swift
//  SourceryHacking
//
//  Created by Bohdan Savych on 15/05/2023.
//

import Foundation

protocol Service: NSObject {
    static var identifier: String { get }

    func load()
    func unload()
}

extension Service {
    func load() {}
    func unload() {}
}

final class ServiceGenerator {
    static let serviceMap = generateTypesDictionary()

    static func setup<T: Service>(object: T) -> T {
        let properties = serviceMap[String(describing: type(of: object))] ?? []
        for property in properties {
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let propertClass = NSClassFromString(nameSpace + "." + property) as! Service.Type
            print(property)
            let propertyObj = setup(object: propertClass.init())
        }

        return object
    }
}
