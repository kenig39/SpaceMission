

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    let player = SKSpriteNode(imageNamed: "playerShip")
    
    let bulletSound = SKAction.playSoundFileNamed("bulletSound.mp3", waitForCompletion: false)
    
    let explosionSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
    
    struct PhysicsCategories {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1 //1
        static let Bullet: UInt32 = 0b10 //2
        static let Enemy: UInt32 = 0b100 //4
    }
    
    func ramdom() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return ramdom() * (max - min) + min
    }
    
    
    
    var gameArea: CGRect
    
    override init(size: CGSize){
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWith = size.height / maxAspectRatio
        let margin = (size.width - playableWith) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWith, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(player)
        
        startNewLevel()
    }
    
    func startNewLevel(){
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([spawn,waitToSpawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy {
            // if the player has hit the enemy
            
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
                
            }
           
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && (body2.node?.position.y)! < self.size.height {
            // if the bullet has hit the enmy
            
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
           // spawnExplosion(spawnPosition: body2.node!.position)
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
        
    }
    
    func spawnExplosion(spawnPosition: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound,scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
        
        
        
    }
    
    func fireBullet(){
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        
        let bulletSequense = SKAction.sequence([bulletSound,moveBullet, deleteBullet])
        bullet.run(bulletSequense)
        
    }
    
    func spawnEnemy(){
        let randomXstart = random(min: CGRectGetMinX(gameArea), max: CGRectGetMaxX(gameArea))
        let randomXEnd = random(min: CGRectGetMinX(gameArea), max: CGRectGetMaxX(gameArea))
        
        let startPoin = CGPoint(x: randomXstart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.setScale(1)
        enemy.position = startPoin
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(enemySequence)
        
        let dx = endPoint.x - startPoin.x
        let dy = endPoint.y - startPoin.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireBullet()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragger = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragger
            
            if player.position.x > CGRectGetMaxX(gameArea) - player.size.width/2 {
                player.position.x = CGRectGetMaxX(gameArea) - player.size.width/2
            }
            
            if player.position.x < CGRectGetMinX(gameArea){
                player.position.x = CGRectGetMinX(gameArea)
            }
            
        }
    }
}
