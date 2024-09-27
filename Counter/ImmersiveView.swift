//
//  ImmersiveView.swift
//  visionDice
//
//  Created by Dwight Benignus on 1/25/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @State var count: Int = 0
    var body: some View {
        RealityView { content in
            let floor = ModelEntity(mesh: .generatePlane(width: 50, depth: 50), materials: [OcclusionMaterial()])
            
            floor.generateCollisionShapes(recursive: false)
            
            floor.components[PhysicsBodyComponent.self] = .init(
                massProperties:.default,
                mode: .static
            )
            floor.position.y = 0
            content.add(floor)
            
            if let zeroModel = try? await Entity(named: "0", in: realityKitContentBundle),
               let zero = zeroModel.findEntity(named: "g0"){

                zero.scale = [0.1, 0.1, 0.1]
                zero.position.y = -0.1
                zero.position.z = -1
                
                zero.generateCollisionShapes(recursive: false)
                zero.components.set(InputTargetComponent())
                zero.components[PhysicsBodyComponent.self] = .init(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .generate(staticFriction: 0.8, dynamicFriction: 0.5, restitution: 0.1),
                    mode: .dynamic
                ))
                zero.components[PhysicsMotionComponent.self] = .init()
                
                content.add(zero)
            }
        }
        update: { content in
            let oldNumber = content.entities.first { entity in
                entity.name == "g0"
            }
            
            if let oldNumber, self.count > 0 {
                oldNumber.removeFromParent()
                let numberModel = try? Entity.load(named: "\(count)", in: realityKitContentBundle)
             
                
                if let numberModel,
                  let number = numberModel.findEntity(named: "g0")
                {
                    number.scale = [0.1, 0.1, 0.1]
                    number.position.y = -0.1
                    number.position.z = -1
                    
                    number.generateCollisionShapes(recursive: false)
                    number.components.set(InputTargetComponent())
                    number.components[PhysicsBodyComponent.self] = .init(PhysicsBodyComponent(
                        massProperties: .default,
                        material: .generate(staticFriction: 0.8, dynamicFriction: 0.5, restitution: 0.1),
                        mode: .dynamic
                    ))
                    number.components[PhysicsMotionComponent.self] = .init()
                    content.add(number)
                }
                
            }
                
        }
        .gesture(dragGesture)
        .onTapGesture(count: 1){ value in
            self.count += 1
            print(self.count)
        }
        
    }
    var dragGesture: some Gesture{
          DragGesture()
            .targetedToAnyEntity()
             .onChanged { value in
                 print("gestre")
                  value.entity.position = value.convert(value.location3D,
                                                        from: .local,
                                                        to: value.entity.parent!)
                   value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
                  }
                .onEnded { value in
                      value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
  
                  }
      }
}

#Preview {
    ImmersiveView()
}
