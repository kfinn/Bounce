import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  lazy var scene = GameScene()
  lazy var skView: SKView = {
    let result = SKView()
    result.translatesAutoresizingMaskIntoConstraints = false
    return result
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(skView)
    view.addConstraints([
      NSLayoutConstraint(item: skView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: skView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: skView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: skView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
    ])
    
    skView.presentScene(scene)
    skView.showsFPS = true
    skView.showsNodeCount = true
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
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override func viewDidLayoutSubviews() {
    scene.size = skView.bounds.size
  }
}
