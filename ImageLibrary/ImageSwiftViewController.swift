//
//  ImageSwiftViewController.swift
//  ImageLibrary
//
//  Created by theodore on 2022/02/27.
//

import UIKit
import Kingfisher

class ImageSwiftViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let url = URL(string: "https://pbs.twimg.com/media/Ex0biHtVIAQ-c56?format=jpg&name=large")
    
    
    let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
    
    if let url = URL(string: "https://pbs.twimg.com/media/Ex0biHtVIAQ-c56?format=jpg&name=large") {
      KingfisherManager.shared.retrieveImage(with:url, completionHandler: { result in
        
      })
    }
    
    imageView.kf.setImage(
      with: url,
      placeholder: nil,
      options: nil) { result in
      switch result {
      case .success(let value):
        print(value)
      case .failure(let value):
        print(value)
      }
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  @IBAction func closeButtonDidTap(_ sender: Any) {
    self.imageView.image = nil;
    self.dismiss(animated: false, completion: nil);
  }
  
}
