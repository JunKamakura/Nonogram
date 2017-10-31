import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
	//プロパティ
	var bgmPlayer: AVAudioPlayer?
	var isBGMPause: Bool = false
	var bgmVolume: Float = 0.5
	var seVolume: Float = 0.5
	var sePlayers: NSMutableSet = NSMutableSet()
	
	//BGM再生開始
	func setBGMSound(filepath: String) {
		self.bgmStop()
		let url: NSURL? = NSURL(fileURLWithPath: filepath, isDirectory: false)
		if url != nil {
            self.bgmPlayer = try? AVAudioPlayer(contentsOf: url! as URL)
			self.bgmPlayer?.delegate = self
			self.bgmPlayer?.numberOfLoops = -1
			self.bgmPlayer?.volume = self.bgmVolume
			self.bgmPlayer?.play()
		}
	}
	//BGM停止
	func bgmStop() {
		self.isBGMPause = false
		self.bgmPlayer?.stop()
	}
	//BGM一時停止
	func bgmPause(pause: Bool) {
		if self.isBGMPause != pause {
			self.isBGMPause = pause;
			if self.isBGMPause {
				self.bgmPlayer?.pause();
			}
			else {
				self.bgmPlayer?.play()
			}
		}
	}
	//SE再生
	func sePlay(name: String, type: String) {
        let filePath = Bundle.main.path(forResource: name, ofType: type)
		if let path=filePath {
			let url = NSURL(fileURLWithPath: path, isDirectory: false)
            let player: AVAudioPlayer = try! AVAudioPlayer(contentsOf: url as URL)
            self.sePlayers.add(player)
			player.delegate = self;
			player.volume = self.seVolume;
			player.play()
		}
	}
	//再生終了
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for pl in self.sePlayers {
			if pl as AnyObject? === player {
                self.sePlayers.remove(pl)
				break
			}
		}
	}
	
}



