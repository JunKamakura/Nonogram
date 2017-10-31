//
//  TitleViewController.swift
//  ArrowShooter
//
//  Created by kama on 2017/10/25.
//  Copyright © 2017年 kama. All rights reserved.
//

import UIKit
import Social

class TitleViewController: UIViewController {
    
    let soundPlayer:SoundPlayer = SoundPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath:String? = Bundle.main.path(forResource: "tammb02",ofType:"mp3")
        if let path = filePath {
            self.soundPlayer.setBGMSound(filepath: path)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

     
    */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        self.soundPlayer.sePlay(name: "se_button",type: "m4a")
        self.soundPlayer.bgmStop()
        
        self.performSegue(withIdentifier: "toGameView", sender: self)
    }
    
    @IBAction func backToTitleAction(_ sender: UIStoryboardSegue) {
        //BGM再生
        let    filePath: String? = Bundle.main.path(forResource: "tammb02", ofType: "mp3")
        if let path = filePath {
            self.soundPlayer.setBGMSound(filepath: path)
        }
    }
}
