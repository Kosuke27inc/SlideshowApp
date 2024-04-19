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
        UIImage(named: "DALL-E_apple.png")!,
        UIImage(named: "DALL-E_fox.png")!,
        UIImage(named: "DALL-E_samurai.png")!
    ]
    var currentImageIndex = 0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageDisplay()
    }

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
            sender.setTitle("Stop", for: .normal)
            nextButton.isEnabled = false
            previousButton.isEnabled = false
        } else {
            stopSlideshow()
            sender.setTitle("Play", for: .normal)
            nextButton.isEnabled = true
            previousButton.isEnabled = true
        }
    }

    func startSlideshow() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImageAutomatically), userInfo: nil, repeats: true)
    }

    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }

    @objc func changeImageAutomatically() {
        nextImage(self)
    }
}


