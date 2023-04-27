//
//  GameViewController.swift
//  ParticleEffects
//
//  Created by Apptist Inc. on 2023-01-19.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    //MARK: - Add the SKScene to our GameViewController
    var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Configure the main view to SKView
        let skView = view as! SKView
        
        //MARK: - Create and configure our game scene
        scene = GameScene(size: skView.bounds.size)
        
        //MARK: - Present this scene on to the SKView
        skView.presentScene(scene)

    }
    

   

}
