
import Foundation
import SpriteKit
let restartLabel = SKLabelNode(fontNamed: "The font")
class GameOverScene: SKScene{
    
    override func didMove(to view: SKView) {
        
        let backgroud = SKSpriteNode(imageNamed: "background")
        backgroud.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroud.zPosition = 0
        self.addChild(backgroud)
        
        let gameOverLable = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLable.text = "Game Over"
        gameOverLable.fontSize = 200
        gameOverLable.fontColor = SKColor.red
        gameOverLable.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameOverLable.zPosition = 1
        self.addChild(gameOverLable)
        
        
        let scoreLable = SKLabelNode(fontNamed: "The bold")
        scoreLable.text = "Score: \(gameScore)"
        scoreLable.fontSize = 125
        scoreLable.fontColor = SKColor.white
        scoreLable.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLable.zPosition = 1
        self.addChild(scoreLable)
        
        let defalt = UserDefaults()
        var highScoreNumber = defalt.integer(forKey: "highScoreSaved")
        
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defalt.set(highScoreNumber, forKey: "highScoreSaved")
        }
        
        let highScorelable = SKLabelNode(fontNamed: "The bold font")
        highScorelable.text = "High Score: \(highScoreNumber)"
        highScorelable.fontSize = 125
        highScorelable.fontColor = SKColor.white
        highScorelable.zPosition = 1
        highScorelable.position = CGPoint(x: self.size.width/2, y: self.size.height*0.45)
        self.addChild(highScorelable)
        
        
        
       
        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        self.addChild(restartLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch){
                let sceneTOMove = GameScene(size: self.size)
                sceneTOMove.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneTOMove, transition: myTransition)
            }
            
            
        }
    }
    
}
