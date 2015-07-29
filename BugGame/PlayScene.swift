//
//  PlayScene.swift
//  BugGame
//
//  Created by Chi Zhang on 7/28/15.
//  Copyright (c) 2015 Chi Zhang. All rights reserved.
//

import Foundation
import SpriteKit

class PlayScene: SKScene {
    
    var tenBugs: [BugModel] = []
    
    var counter: Int = 0
    let scoreText = SKLabelNode(fontNamed: "ArialMT")
    

    override func didMoveToView(view: SKView) {
        println("new scene")
        self.backgroundColor = UIColor.whiteColor()
        
        self.scoreText.text = "0"
        self.scoreText.fontSize = 100
        self.scoreText.position = CGPoint(x: CGRectGetMaxX(self.frame)/2, y: 40.0)
        self.scoreText.fontColor = SKColor.greenColor()
        self.addChild(scoreText)
        
        for i in 0..<10 {
            var newBug = BugModel()
            startBug(newBug)
            tenBugs.append(newBug)
            self.addChild(tenBugs[i].spriteNode)
        }
        
        println("\(tenBugs.count)")
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        for i in 0..<10 {
            let v = tenBugs[i].velocity!
            tenBugs[i].spriteNode.position.x += v.x
            tenBugs[i].spriteNode.position.y += v.y
            tenBugs[i].spriteNode.zRotation = atan(v.x / v.y) - CGFloat(M_PI / 2)
            tenBugs[i].bounce(self.scene!.size.width, maxY: self.scene!.size.height)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        let what = self.nodeAtPoint(location)
        
        for i in 0..<10 {
            if what == tenBugs[i].spriteNode {
                tenBugs[i].velocity = CGPoint(x: 0.0, y: 0.0)
                self.counter++
                self.scoreText.text = "\(self.counter)"
                startBug(tenBugs[i])
            }
        }
    }
    

    func startBug(bug: BugModel) {
        let x = arc4random_uniform(UInt32(self.scene!.size.width - bug.spriteSize.width))
        let y = arc4random_uniform(UInt32(self.scene!.size.height - bug.spriteSize.height))
        bug.setRandomPosition(Double(x), y: Double(y))
        bug.setRandomVelocity()
    }
    
}
