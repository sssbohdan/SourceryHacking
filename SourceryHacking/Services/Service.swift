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
    static let serviceMap2 = allClasses(with: Service.self)
    static let serviceMap3 = withAllClasses { $0.compactMap { $0 as? Service.Type } }

    static func setup<T: Service>(object: T) -> T {
        print(serviceMap3)
        let properties = serviceMap[String(describing: type(of: object))] ?? []
        for property in properties {
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let propertClass = NSClassFromString(nameSpace + "." + property) as! Service.Type
            print(property)
            let propertyObj = setup(object: propertClass.init())
        }

        return object
    }

    static func withAllClasses<R>(
      _ body: (UnsafeBufferPointer<AnyClass>) throws -> R
    ) rethrows -> R {

      var count: UInt32 = 0
      let classListPtr = objc_copyClassList(&count)
      defer {
        free(UnsafeMutableRawPointer(classListPtr))
      }
      let classListBuffer = UnsafeBufferPointer(
        start: classListPtr, count: Int(count)
      )

      return try body(classListBuffer)
    }

    private static func allClasses<R>(with type: R.Type) -> [R.Type] {
        var count: UInt32 = 0
        let classListPtr = objc_copyClassList(&count)
        defer {
            free(UnsafeMutableRawPointer(classListPtr))
        }
        let classListBuffer = UnsafeBufferPointer(start: classListPtr, count: Int(count))

        return classListBuffer.compactMap { $0 as? R.Type }
    }

    private static func buildServiceMap(for services: [Service.Type]) -> [String: [String]] {
        var map = [String: [String]]()

        for service in services {
            let mirror = Mirror(reflecting: service.init())
            let childrens = mirror.children
            var properties = [String]()
            for children in childrens {
                if children.value is Service {
                    properties.append(String(describing: children.value.self))
                }
            }

            map[String(describing: service)] = properties
        }

        return map
    }
}
