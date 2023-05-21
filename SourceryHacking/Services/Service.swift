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
    static let allServices: [Service.Type] = allClasses()
    static let servicesMap = buildServiceMap(for: allServices)

    static func setup<T: Service>(object: T) -> T {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let properties = serviceMap[String(describing: type(of: object))] ?? []
        for property in properties {
            let propertClass = NSClassFromString(nameSpace + "." + property) as! Service.Type
            print(property)
            let propertyObj = setup(object: propertClass.init())
        }

        return object
    }

    private static func allClasses<R>() -> [R] {
        var count: UInt32 = 0
        let classListPtr = objc_copyClassList(&count)
        defer {
            free(UnsafeMutableRawPointer(classListPtr))
        }
        let classListBuffer = UnsafeBufferPointer(start: classListPtr, count: Int(count))

        return classListBuffer.compactMap { $0 as? R }
    }

    private static func buildServiceMap(for services: [Service.Type]) -> [String: [String]] {
        var map = [String: [String]]()

//        for service in services {
//            let mirror = Mirror(reflecting: service.init())
//            let childrens = mirror.children
//            var properties = [String]()
//            for children in childrens {
//                if type(of: children.value) is Optional<Service>.Type {
//                    properties.append(String(describing: children.value.self))
//                }
//            }
//
//            map[String(describing: service)] = properties
//        }

        return map
    }
}
