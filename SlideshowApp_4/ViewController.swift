//
//  ViewController.swift
//  SlideshowApp_4
//
//  Created by Kosuke Miyazaki on 2024/04/19.
//

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.image = images[currentImageIndex]
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playStopButton: UIButton!

    var images: [UIImage] = [
        UIImage(named: "Lesson 5課題用画像/DALL-E_apple.png")!,
        UIImage(named: "Lesson 5課題用画像/DALL-E_fox.png")!,
        UIImage(named: "Lesson 5課題用画像/DALL-E_samurai.png")!
    ]

    var currentImageIndex = 0
    var timer: Timer?

    func updateImageDisplay() {
        imageView.image = images[currentImageIndex]
    }

    @IBAction func nextImage(_ sender: Any) {
        currentImageIndex = (currentImageIndex + 1) % images.count
        updateImageDisplay()
    }

    @IBAction func previousImage(_ sender: Any) {
        currentImageIndex = (currentImageIndex - 1 + images.count) % images.count
        updateImageDisplay()
    }

    @IBAction func playStopToggle(_ sender: UIButton) {
        if timer == nil {
            startSlideshow()
            sender.setTitle("停止", for: .normal)
            nextButton.isEnabled = false
            previousButton.isEnabled = false
        } else {
            stopSlideshow()
            sender.setTitle("再生", for: .normal)
            nextButton.isEnabled = true
            previousButton.isEnabled = true
        }
    }

    func startSlideshow() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImageAutomatically), userInfo: nil, repeats: true)
    }

    @objc func changeImageAutomatically() {
        nextImage(self)
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if timer != nil {
            stopSlideshow()
        }
        playStopButton.setTitle("再生", for: .normal)
           nextButton.isEnabled = true
           previousButton.isEnabled = true
           performSegue(withIdentifier: "showDetail", sender: self)
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestureRecognizer()
        updateImageDisplay()
    }

    func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }

func stopSlideshow() {
    timer?.invalidate()
    timer = nil
    playStopButton.setTitle("再生", for: .normal)
    nextButton.isEnabled = true
    previousButton.isEnabled = true
}
}


