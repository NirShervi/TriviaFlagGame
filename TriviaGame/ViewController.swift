//
//  ViewController.swift
//  TriviaGame
//
//  Created by Nir Shervi on 24/05/2022.
//
import UIKit

class ViewController: UIViewController {
    
    //UI -

    // shows the messages for explanations
    @IBOutlet var textDes: UITextView!
    // image view
    @IBOutlet var imageView: UIImageView!
    // all buttons  - 4 options to choose
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    // show the number of question
    @IBOutlet var MyIndex: UILabel!
    // heart counter
    @IBOutlet var MyHearts: UILabel!
    // prigress bar
    @IBOutlet var progressBar: UIProgressView!
    
    
    
    // Variables -
    
    var randomNumbers = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
    var myUrl = ""
    var startOver = true
    var time = 2.0
    var restart = false
    var progress = 0.0
    var index = 0
    var counter = 0
    var hearts = 3
    var data = JsonManager().question
    
    @IBAction func btn1Action(_ sender: Any) {
        if(data[index].correct == 1){
            counter += 1
        }
        else{
            hearts -= 1
        }
        index += 1
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
        
            if(self.index <= 15){
                self.gameManager()
            }
            else{
                
            }
        }
    }
    
    @IBAction func btn2Action(_ sender: Any) {
        if(data[index].correct == 2){
            counter += 1
        }
        else{
            hearts -= 1
        }
        index += 1
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
        
            if(self.index <= 15){
                self.gameManager()
            }
            else{
                
            }
        }
    }
    
    @IBAction func btn3Action(_ sender: Any) {
        
        if(!startOver){
        if(data[index].correct == 3){
            counter += 1
        }
        else{
            hearts -= 1
        }
        index += 1
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
        
            if(self.index <= 15){
                self.gameManager()
            }
            else{
            }
        }
        }else{
            
            startOver = false
            index = 0
            counter = 0
            hearts = 3
            self.btn2.isHidden = false
            self.btn1.isHidden = false
            self.btn4.isHidden = false
            self.btn3.tintColor = UIColor.white
            progress = 0.0
            self.progressBar.setProgress(Float(progress), animated: false)
            gameManager()
            
        }
    }
    
    @IBAction func btn4Action(_ sender: Any) {
        if(data[index].correct == 4){
            counter += 1
        }
        else{
            hearts -= 1
        }
        index += 1
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
        
            if(self.index <= 15){
                self.gameManager()
            }
            else{
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.shuffle()
        newGame()
        
        
        
    }
    
    func newGame(){
        
        btn2.isHidden = true
        btn1.isHidden = true
        btn4.isHidden = true
        btn3.setTitle("Start", for: .normal)


    }
    
    func gameManager(){
        
        if (hearts > 0){
            if (index <= 14){
                myUrl = data[index].image
                retriveFromJson()
                // progress bar
                self.progress = progress + 0.065
                self.progressBar.setProgress(Float(progress), animated: false)
                
                // counter of hearts and index
                MyIndex.text = String(counter)
                MyHearts.text = String(hearts)
                
                // after hidding the buttons and retrive them back we need to set tint again.
                btn1.tintColor = UIColor.white
                btn2.tintColor = UIColor.white
                btn3.tintColor = UIColor.white
                btn4.tintColor = UIColor.white
                
                //make sure nothing is written on explnation box text
                textDes.text = ""
                
                // set buttons value
                btn1.setTitle(data[index].answer1, for: .normal)
                btn2.setTitle(data[index].answer2, for: .normal)
                btn3.setTitle(data[index].answer3, for: .normal)
                btn4.setTitle(data[index].answer4, for: .normal)
                
                
            } else {
                MyIndex.text = String(counter)
                imageView.image = UIImage(named: "winner-page")
                textDes.text = "Score: " + String(counter) + ", well done !"
                self.progressBar.setProgress(Float(1.0), animated: false)
                startOver = true
                newGame()
            }
        }else {
            MyHearts.text = String(hearts)
            imageView.image = UIImage(named: "loser-page")
            textDes.text = "Score: " + String(counter) + ", you lost !"
            startOver = true
            newGame()
        }
    }
    
    func retriveFromJson(){
        guard let urll = URL(string: myUrl) else {
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: urll) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
        getDataTask.resume()
    }
}
