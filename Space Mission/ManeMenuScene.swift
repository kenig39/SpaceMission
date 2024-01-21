
import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    
    override func didMove(to view: SKView) {
        let backGround = SKSpriteNode(imageNamed: "background")
        backGround.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backGround.zPosition = 0
        self.addChild(backGround)
        
        let gameBy = SKLabelNode(fontNamed: "the bold")
        gameBy.text = "Alex & CO"
        gameBy.fontSize = 50
        gameBy.fontColor = SKColor.white
        gameBy.position = CGPoint(x: self.size.width*0.5, y: self.size.height/2)
        gameBy.zPosition = 1
        self.addChild(gameBy)
        
        let gameName = SKLabelNode(fontNamed: "the bold")
        gameName.text = "Space"
        gameName.fontSize = 200
        gameName.fontColor = SKColor.white
        gameName.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameName.zPosition = 1
        self.addChild(gameName)
        
        
        let gameName1 = SKLabelNode(fontNamed: "the bold")
        gameName1.text = "Mission"
        gameName1.fontColor = SKColor.white
        gameName1.fontColor = SKColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.625)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        let startGame = SKLabelNode(fontNamed: "the bold")
        startGame.text = "Start Game"
        startGame.fontSize = 150
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        startGame.zPosition = 1
        startGame.name = "startButton"
        self.addChild(startGame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let nodeItapped = atPoint(pointOfTouch)
            
            if nodeItapped.name == "startButton"{
                let sceneToMove = GameScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMove, transition: myTransition)
            }
        }
    }
    
}
