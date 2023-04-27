 //
//  GameScene.swift
//  ParticleEffects
//
//  Created by Apptist Inc. on 2023-01-19.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    
    //particles effect
    let particle = SKEmitterNode(fileNamed: "Bokeh.sks")
    let particle2 = SKEmitterNode(fileNamed: "Rain.sks")
    let particle3 = SKEmitterNode(fileNamed: "Spark.sks")
    //MARK: - Sprites
  
    var playerNode = SKSpriteNode(imageNamed: "Player")
    var enemy1 = SKSpriteNode(imageNamed: "BlackHole1")
    var enemy2 = SKSpriteNode(imageNamed: "BlackHole2")
    var friend = SKSpriteNode(imageNamed: "PowerUp")
    
    var scoreLabel = SKLabelNode(text: "Score: 0")
    var backgroundNode = SKSpriteNode(imageNamed: "Background")
    
    // bounce back velocity when a node touches or reached screenwidth
    var velocityX = 10
    var velocityY = 10

    //MARK: - Actions
    var moveAction: SKAction?
    var scaleAction: SKAction?
    var alphaOutAction: SKAction?
    var colourAction: SKAction?
    var alphaInAction: SKAction?
    
    //SCORE
    var Score=0;
   

    override init(size: CGSize) {
        
        super.init(size: size)
    }
    
    //logid moved to didMove as per documentation it is better to do it in didmove.
    override func didMove(to view: SKView) {

        physicsWorld.contactDelegate = self
        self.backgroundColor = .blue
        
        // Define physics categories of players and enemies so that collision can happen
        let player: UInt32 = 0x1 << 1
        let otherNodes: UInt32 = 0x1 << 2

        //MARK: - Physics
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.7)
 
        //MARK: - Player sprite
        playerNode.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 6.0)
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width)
        playerNode.physicsBody?.categoryBitMask = player
        playerNode.physicsBody?.collisionBitMask = otherNodes
        playerNode.physicsBody?.contactTestBitMask = otherNodes
        playerNode.physicsBody?.isDynamic = true
        playerNode.physicsBody?.affectedByGravity=true;
        addChild(playerNode)
        
        
        //: - enemy sprite 1
        enemy1.position = CGPoint(x: self.size.width / 1.5, y: self.size.height / 1.2)
        enemy1.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width)
        enemy1.physicsBody?.categoryBitMask = otherNodes
        enemy1.physicsBody?.isDynamic = true
        enemy1.physicsBody?.affectedByGravity=false;
        addChild(enemy1)
        
        
        //: - friend sprite
        friend.position = CGPoint(x: self.size.width / 6.0, y: self.size.height / 6.0)
        friend.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width)
        friend.physicsBody?.categoryBitMask = otherNodes
        friend.physicsBody?.isDynamic = true
        friend.physicsBody?.affectedByGravity=false;
        addChild(friend)
        
        
        //: - enemy2 sprite
        enemy2.position = CGPoint(x: self.size.width / 3.0, y: self.size.height / 2)
        enemy2.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width)
        enemy2.physicsBody?.categoryBitMask = otherNodes
        enemy2.physicsBody?.isDynamic = true
        enemy2.physicsBody?.affectedByGravity=false;
        addChild(enemy2)
        
        //MARK: - Background sprite
        backgroundNode.size.width = frame.size.width
        backgroundNode.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)
        addChild(backgroundNode)
        backgroundNode.zPosition = -1
        
        
        
        //MARK: - Add a particle effect
        //Particle effects intialisation
        
        particle?.particleSize = CGSize(width: 1, height: 1)
        particle?.position = CGPoint(x: self.size.width / 1.5, y: self.size.height / 1.5)
        addChild(particle!)

        // background effects
        particle2?.particleSize = CGSize(width: frame.width, height: 2)
        particle2?.position = CGPoint(x: self.size.width , y: frame.height)
        addChild(particle2!)

        // starts when game overs
        particle3?.particleSize = CGSize(width: 7, height: 7)
        particle3?.position = CGPoint(x: self.size.width / 2, y: self.size.height / 5)
        particle3?.isHidden = true
        addChild(particle3!)



        //MARK: - Init my actions
       
        // continoulsy moving nodes
        let moveAction = SKAction.move(by: CGVector(dx: 10, dy: 120), duration: 1)
        let moveActionn = SKAction.move(by: CGVector(dx: 120, dy: 10), duration: 1)
        let continuousMovement = SKAction.repeatForever(SKAction.sequence([moveAction,moveActionn, moveAction.reversed()]))
        enemy1.run(continuousMovement)

        
        let moveAction2 = SKAction.move(by: CGVector(dx: 150, dy: 150), duration: 1)
        let continuousMovement2 = SKAction.repeatForever(SKAction.sequence([moveAction2,moveActionn, moveAction2.reversed()]))
        friend.run(continuousMovement2)

    
        let moveAction3 = SKAction.move(by: CGVector(dx: 90, dy: 120), duration: 1)
        let continuousMovement3 = SKAction.repeatForever(SKAction.sequence([moveAction3,moveActionn, moveAction3.reversed()]))
        enemy2.run(continuousMovement3)


//          scaleAction = SKAction.scale(by: 2.0, duration: 1.0)
//         // playerNode.run(scaleAction!)
//          alphaOutAction = SKAction.fadeOut(withDuration: 2.0)
//        //  playerNode.run(alphaAction!)
//          colourAction = SKAction.colorize(with: .green, colorBlendFactor: 1.0, duration: 2.0)
//         // playerNode.run(colourAction!)
//          alphaInAction = SKAction.fadeIn(withDuration: 2.0)
          //playerNode.run(SKAction.repeatForever(SKAction.sequence([moveAction!, scaleAction!, colourAction!, alphaOutAction!, alphaInAction!])))
        
        
        // Score label settings at bottom left
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: self.size.width / self.size.width+50, y: self.size.height / self.size.height+20)
        addChild(scoreLabel);
        
        
    

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("test me")
        //MARK: - Apply a force to the player sprite when the screen is touched
        playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 50.0))
        //playerNode.run(moveAction!)
        //MARK: - Add action that changes size of player when the screen is touched
    
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
        
        print("test")
        if (contact.bodyA.node == playerNode && contact.bodyB.node == friend)
            {
                updateScore(update: 1)
                print("yo")
            }
        if (contact.bodyA.node == playerNode && contact.bodyB.node == enemy1) ||
                  (contact.bodyA.node == playerNode && contact.bodyB.node == enemy2) {
                  updateScore(update: -1)
            
            }
        
      
    }
    override func update(_ currentTime: TimeInterval) {
        
           // Check if spirekits nodes is going off the screen and keep nodes inside the screen
        
           if playerNode.position.x - playerNode.frame.width/4 < 0 ||
              playerNode.position.x + playerNode.frame.width/4 > self.frame.width ||
              playerNode.position.y + playerNode.frame.height/2 > self.frame.height
            {
               // Prevent the node from going off the screen
               playerNode.position.x = max(playerNode.frame.width/2, min(self.frame.width - playerNode.frame.width/2, playerNode.position.x))
               playerNode.position.y = max(playerNode.frame.height/2, min(self.frame.height - playerNode.frame.height/2, playerNode.position.y))
            }
        
        //GameOver condition
           if playerNode.position.y < 0
           {
            // Show the "Game Over" message
                let gameOverLabel = SKLabelNode(text: "Game Over")
                gameOverLabel.fontSize = 40
                gameOverLabel.fontColor = .white
                gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                self.addChild(gameOverLabel)
               particle3?.isHidden=false;
                
                // Pause the game
               // self.isPaused = true
          }
        
          if friend.position.x - friend.frame.width/2 < 0 ||
             friend.position.x + friend.frame.width/2 > self.frame.width ||
             friend.position.y - friend.frame.height/2 < 0 ||
             friend.position.y + friend.frame.height/2 > self.frame.height
        {
               // Prevent the node from going off the screen
               friend.position.x = max(friend.frame.width/2, min(self.frame.width - friend.frame.width/2, friend.position.x))
               friend.position.y = max(friend.frame.height/2, min(self.frame.height - friend.frame.height/2, friend.position.y))
        }

            var newPosition = enemy1.position
            newPosition.x += CGFloat(velocityX)
            newPosition.y += CGFloat(velocityY)
            
            // Check if the node has reached the screen boundary
            if newPosition.x < enemy1.frame.width/2 || newPosition.x > frame.width - enemy1.frame.width/2 {
              velocityX = -velocityX
              newPosition.x = enemy1.position.x
            }
            if newPosition.y < enemy1.frame.height/2 || newPosition.y > frame.height - enemy1.frame.height/2 {
              velocityY = -velocityY
              newPosition.y = enemy1.position.y
            }
            
            // Update the node's position
            enemy1.position = newPosition
        

            if enemy2.position.x - enemy2.frame.width/2 < 0 ||
                enemy2.position.x + enemy2.frame.width/2 > self.frame.width ||
                enemy2.position.y - enemy2.frame.height/2 < 0 ||
                enemy2.position.y + enemy2.frame.height/2 > self.frame.height
           {
               // Prevent the node from going off the screen
               enemy2.position.x = max(enemy2.frame.width/2, min(self.frame.width - enemy2.frame.width/2, enemy2.position.x))
               enemy2.position.y = max(enemy2.frame.height/2, min(self.frame.height - enemy2.frame.height/2, enemy2.position.y))
           }
       
       }
    
    

    
    func didEnd(_ contact: SKPhysicsContact) {
        //MARK: - After contact has ended between two bodies
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // custom functions
    func updateScore(update: Int) {
        Score=Score+update;
        scoreLabel.text = "Score: \(Score)"
    }
    
    

    
}
