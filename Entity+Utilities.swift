//
//  Entity+Utilities.swift
//  TouristMap
//
//  Created by Koichi Kishimoto on 2024/03/27.
//

import RealityKit

public extension Entity {
        
    var collisionComponent: CollisionComponent? {
        get { components[CollisionComponent.self] }
        set { components[CollisionComponent.self] = newValue }
    }
    
    /// Recursive search of children looking for any descendants with a specific component and calling a closure with them.
    func forEachDescendant<T: Component>(withComponent componentClass: T.Type, _ closure: (Entity, T) -> Void) {
        for child in children {
            if let component = child.components[componentClass] {
                closure(child, component)
            }
            child.forEachDescendant(withComponent: componentClass, closure)
        }
    }
    
    func adjustCollisionBox(scaleBy: SIMD3<Float>, offsetBy: SIMD3<Float>) {
        if var component = collisionComponent {
            if let shape = component.shapes.first {
                let calculatedBounds = shape.bounds
                let newBoxOffset = ShapeResource.generateBox(width: calculatedBounds.extents.x * scaleBy.x,
                                                             height: calculatedBounds.extents.y * scaleBy.y,
                                                             depth: calculatedBounds.extents.z * scaleBy.z)
                let newBox = newBoxOffset.offsetBy(translation: offsetBy)
                
                component.shapes.removeAll()
                component.shapes.append(newBox)
            }
            components.set(component)
        }
    }
}
