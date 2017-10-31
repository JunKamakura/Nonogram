//
//  GameViewController.swift
//  ArrowShooter
//
//  Created by kama on 2017/10/25.
//  Copyright © 2017年 kama. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let soundPlayer: SoundPlayer = SoundPlayer()
    
    @IBOutlet var Square: [UIView]!
    @IBOutlet var Close: [UILabel]!
    @IBOutlet var NumRow: [UILabel]!
    @IBOutlet var NumCol: [UILabel]!
    
    @IBOutlet weak var middleBarView: UIView!
    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet weak var backToTitleButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var AnswerWord: UILabel!
    @IBOutlet weak var Question: UILabel!
    
    var AnswerWords: [String] = [""]
    var Answers: [[Int]] = [[]]
    var NumRows: [[Int]] = [[]]
    var NumCols: [[Int]] = [[]]
    
    var nowQuestion: Int = 0
    var selectSqouare: Int = 0
    var tapSquare: [Int] = [0]
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        self.soundPlayer.sePlay(name: "se_button", type: "m4a")
        let pause = self.middleBarView.isHidden
        self.soundPlayer.bgmPause(pause: pause)
        
        self.middleBarView.isHidden = !pause
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnswerWords += ["時計"]
        Answers += [[0,1,1,1,0,1,0,1,0,1,1,0,1,1,1,1,0,0,0,1,0,1,1,1,0]]
        NumRows += [[0,0,3,1,1,1,0,1,3,0,1,1,0,0,3]]
        NumCols +=  [[0,0,3,0,1,1,0,3,1,1,1,1,0,0,3]]
        
        AnswerWords += ["ねじ"]
        Answers += [[1,1,0,1,1,1,0,1,0,1,1,1,1,1,1,0,0,1,0,0,0,1,1,1,0]]
        NumRows += [[0,2,2,1,1,1,0,0,5,0,0,1,0,0,3]]
        NumCols +=  [[0,0,3,1,1,1,0,0,4,1,1,1,0,0,3]]
        AnswerWords += ["家"]
        Answers += [[0,0,1,0,0,0,1,1,1,0,1,1,1,1,1,0,1,0,1,0,0,1,1,1,0]]
        NumRows += [[0,0,1,0,0,3,0,0,5,0,1,1,0,0,3]]
        NumCols +=  [[0,0,1,0,0,4,0,3,1,0,0,4,0,0,1]]
        
        nowQuestion = 1
        NewGame()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func ViewTapped(_ sender: UITapGestureRecognizer) {
        for sq in Square {
            sq.layer.borderWidth = 0
        }
        sender.view?.layer.borderWidth = 2.0
        sender.view?.layer.borderColor = UIColor.red.cgColor
        selectSqouare = (sender.view?.tag)!
    }
    
    @IBAction func CheckButtonAction(_ sender: Any) {
        self.soundPlayer.sePlay(name: "se_button",type: "m4a")
        
        if Square[selectSqouare].backgroundColor == UIColor.black {
            Square[selectSqouare].backgroundColor = UIColor.white
            tapSquare[selectSqouare] = 0
        } else {
            Square[selectSqouare].backgroundColor = UIColor.black
            tapSquare[selectSqouare] = 1
        }
        
        Close[selectSqouare].isHidden = true
        
        Answer()
    }
    @IBAction func CloseButtonAction(_ sender: Any) {
        self.soundPlayer.sePlay(name: "se_button",type: "m4a")
        
        Square[selectSqouare].backgroundColor = UIColor.white
        tapSquare[selectSqouare] = 0
        
        if Close[selectSqouare].isHidden == true {
            Close[selectSqouare].isHidden = false
        } else {
            Close[selectSqouare].isHidden = true
        }

        Answer()
    }
    
    @IBAction func NextStageAction(_ sender: Any) {
        if nowQuestion >= 3 {
            let alertController = UIAlertController(title: "",message: "未実装です", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
    //            print("OK")
            }
            alertController.addAction(okAction)
            present(alertController,animated: true,completion: nil)
        } else {
            nowQuestion += 1
            NewGame()
        }
    }
    
    private func Answer() {
        if tapSquare == Answers[nowQuestion] {
            self.AnswerWord.text = AnswerWords[nowQuestion]
            
            self.Question.isHidden = true
            self.answerView.isHidden = false
            self.CheckButton.isHidden = true
            self.CloseButton.isHidden = true
            self.pauseButton.isHidden = true
            
            self.soundPlayer.bgmStop()
            self.soundPlayer.sePlay(name: "se_maoudamashii_chime14",type: "mp3")
        }
    }
    
    private func NewGame() {
        self.Question.text = nowQuestion.description + "問目"
        
        tapSquare.removeAll()
        tapSquare.append(0)
        for (index, sq) in Square.enumerated() {
            sq.backgroundColor = UIColor.white
            sq.layer.borderWidth = 0
            sq.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewTapped(_:))))
            sq.tag = index
            if index > 0 {
                tapSquare.append(0)
            }
        }
        for (index, cl) in Close.enumerated() {
            cl.isHidden = true
            cl.tag = index
        }
        for (index, nr) in NumRow.enumerated() {
            if NumRows[nowQuestion][index] == 0 {
                nr.isHidden = true
            } else {
                nr.isHidden = false
                nr.text = NumRows[nowQuestion][index].description
            }
        }
        for (index, nc) in NumCol.enumerated() {
            if NumCols[nowQuestion][index] == 0 {
                nc.isHidden = true
            } else {
                nc.isHidden = false
                nc.text = NumCols[nowQuestion][index].description
            }
        }
        
        selectSqouare = 0
        Square[selectSqouare].layer.borderWidth = 2.0
        Square[selectSqouare].layer.borderColor = UIColor.red.cgColor
        
        let    filePath: String? = Bundle.main.path(forResource: "tammb06", ofType: "mp3")
        if let path = filePath {
            self.soundPlayer.setBGMSound(filepath: path)
        }
        
        self.Question.isHidden = false
        self.answerView.isHidden = true
        self.CheckButton.isHidden = false
        self.CloseButton.isHidden = false
        self.pauseButton.isHidden = false
    }
    
}
