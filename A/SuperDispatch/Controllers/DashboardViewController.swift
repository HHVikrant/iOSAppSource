
import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var lblReport: UILabel!

    class func initViewController() -> DashboardViewController  {
        let controller = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        controller.title = "Home"
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if damagesArray.count > 0 {
            var fullString = "";
            for aString in damagesArray {
                fullString.append("\(fullString), \(aString)")
            }
//            lblReport.text = "\(damagesArray.count) damages: \(fullString)"
        }
    }

    @IBAction func btnClicked(_ sender: Any) {
        let controller = CarrierViewController.initViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
