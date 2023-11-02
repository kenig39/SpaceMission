//
//  GameViewController.swift
//  Solo Mission
//
//  Created by Alexander on 17.01.2024.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
            let scene = GameScene(size: CGSize(width: 1536, height: 2048))
        
        let skView = self.view as! SKView
               
                scene.scaleMode = .aspectFill
                
               
                skView.presentScene(scene)
            
            
            skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
