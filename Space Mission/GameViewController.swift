//
//  GameViewController.swift
//  Solo Mission
//
//  Created by Alexander on 17.01.2024.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation


class GameViewController: UIViewController {

  var backingAudio = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let filePath = Bundle.main.path(forResource: "galactic", ofType: "mp3")
        let audioNSURL = URL(filePath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer(contentsOf: audioNSURL) }
                catch {
                    return print("cannot find the audio")
                }
        backingAudio.numberOfLoops = -1
        backingAudio.play()
        
        
       
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
        
            let skView = self.view as! SKView
               
                scene.scaleMode = .aspectFill
                
               
                skView.presentScene(scene)
            
            
            skView.ignoresSiblingOrder = true
            
            skView.showsFPS = false
            skView.showsNodeCount = false
        
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
