//whenever u see ".' you are accessing properties from somewhere
//  GameScene.swift
//  AngryDuck
//  Created by Milhouse Tattoos on 9/14/19.
//  Copyright © 2019 Estudie Ingles. All rights reserved.
import SpriteKit
import GameplayKit
class GameScene: SKScene {
        var duck: SKSpriteNode!
        var originalDuckPos: CGPoint!
        
        var hasGone = false
        var boxes = [SKSpriteNode]()   //array but i think this is a dictionary
        var boxOriginalPositions = [CGPoint]()
        
        override func didMove(to view: SKView) {
            //downcasted into an SKSpriteNode //childNode method provided by apple
              //"duck" came from the name at gamescene.sks where you did all your dreadful designing
               duck = childNode(withName: "duck") as? SKSpriteNode
                //since we dont want duck to fall yet, until we slingshot it
                 originalDuckPos = duck.position
                  //a bounding box prevents from stuff moving outside view screen
                   //physicsBody seems to be from apple //this physicsBody will get used alot!!
                     physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
                        //        for i in 0...7 {
                        //            if let box = childNode(withName: "box\(i)") as? SKSpriteNode {
                        //                boxes.append(box)
                        //                boxOriginalPositions.append(box.position)
                        //        }
                        //    }
                    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                   //pulling back on the slingshot//touchedWhere created by us
                    let touchedWhere = nodes(at: touchLocation)
                      //we need to check if its empty //because we have multiple objects we need to loop though it
                        // the ! is checking if its empty
                         if !touchedWhere.isEmpty{
                          for node in touchedWhere {
                            //downcasting
                            if let sprite = node as? SKSpriteNode {
                               //downcasting again
                               if sprite == duck {
                                   duck.position = touchLocation
                               }
                           }
                       }
                   }
               }
           }
       }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone {   //my note: checking if empty
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                  let touchedWhere = nodes(at: touchLocation)
                    if !touchedWhere.isEmpty {
                        for node in touchedWhere {
                            if let sprite = node as? SKSpriteNode {
                              if sprite == duck {
                                 //made duck snap back to its original position when it has been dragged further than
                                    if duck.position.x > 0.0 {
                                         duck.position = originalDuckPos
                                          } else {
                                            duck.position = touchLocation
                                         }
                                     }
                                 }
                            }
                        }
                    }
                }
            }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone {
            if let touch = touches.first {
               let touchLocation = touch.location(in: self)
                 //pulling back on the slingshot//touchedWhere created by us
                  let touchedWhere = nodes(at: touchLocation)
                   //we need to check if its empty //because we have multiple objects we need to loop though it
                    // the ! is checking if its empty
                     if !touchedWhere.isEmpty {
                      for node in touchedWhere {
                       //downcasting
                       if let sprite = node as? SKSpriteNode {
                        //downcasting again
                           // this is a copy of the duck but has same properties
                            if sprite == duck {
                             // this "-" and brackets () is whats making it sling
                             let dx = -(touchLocation.x - originalDuckPos.x)
                              let dy = -(touchLocation.y - originalDuckPos.y)
                              //pushing the duck with code
                               let impulse = CGVector(dx: dx, dy: dy) //im guessing CGVector is the sling function
                                duck.physicsBody?.applyImpulse(impulse)
                                 // making it turn/dynamic/clockwise
                                  //pay attention to CGFloat vs CGVector //CGFloat holds 32 or 64 bits of data. CG=core graphics
                                   //CGVector is string of content of the form {dx,dy} with dx being xcoordinate of the vector
                                    duck.physicsBody?.applyAngularImpulse(-0.01)
                                     // you can print the impulse here
                                     duck.physicsBody?.affectedByGravity = true
                                      hasGone = true
                                   }
                               }
                           }
                       }
                  }
             }
        }
    //resetting to relsingshot the duck again
     // checking if velocity is 0, or in other words-optional binding
      override func update(_ currentTime: TimeInterval) {
        if let duckPhysicsBody = duck.physicsBody {
         // optional binding is to check whether the optional has a value or notf. If it does contain a value, unwrap it and put it into a temporary constant or variable
           if duckPhysicsBody.velocity.dx <= 0.1 && duckPhysicsBody.velocity.dy <= 0.1 && duckPhysicsBody.angularVelocity <= 0.1 && hasGone {
            // this is checking if the duck has completely stopped moving
             // need to check if hasGone is true
              //we dont want duck affected by gravity
                duck.physicsBody?.affectedByGravity = false
                  //we need to reset the ducks velocity
                    duck.physicsBody?.velocity = CGVector (dx: 0, dy: 0)
                     //we need to reset the velocity//helped with the pull-back-gravity
                      duck.physicsBody?.angularVelocity = 0.1
                       //resetting the angle
                        duck.zRotation = 0.01
                         // once reset to 0, we can reset duck position to original
                          duck.position = originalDuckPos
                           //if its all stopped
                             hasGone = false
                    
            
            // 3: When you reset, loop through the boxes and set them to its original position, rotation and velocity
                   
//            for i in 0...7 {
//                let originalPos = boxOriginalPositions[i]
//                let box = boxes[i]
//                box.position = originalPos
//                box.zRotation = 0.0
//                box.physicsBody?.velocity = CGVector.zero
//                box.physicsBody?.angularVelocity = 0.0
//
//
//            }
        
        }
     }
  }
}
