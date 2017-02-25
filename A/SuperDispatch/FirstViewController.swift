
import UIKit

class FirstViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {

    let picker = UIImagePickerController()
    var imgArray : NSMutableArray = NSMutableArray()
    var touchPoint : CGPoint = CGPoint()
    
    @IBOutlet weak var carView: UIView!
    @IBOutlet weak var tblViewMain: UITableView!
    @IBOutlet weak var collViewMain: UICollectionView!
    
    
    class func initViewController() -> FirstViewController  {
        let controller = FirstViewController(nibName: "FirstViewController", bundle: nil)
        controller.title = "First"
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        collViewMain.register(UINib(nibName: "ImgCell", bundle: nil), forCellWithReuseIdentifier: "ImgCell")
        
        tblViewMain.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        picker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreActions))
        tap.numberOfTapsRequired = 1
        carView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
//    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
////    return .landscapeLeft
//    }
    
    func showMoreActions(touch: UITapGestureRecognizer) {
        touchPoint = touch .location(in: carView)
        tblViewMain.isHidden = false;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("photo is selected")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgArray.add(chosenImage)
        collViewMain.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotosClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
//            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    
    func noCamera(){
        let alertVC = UIAlertController( title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC, animated: true,   completion: nil)
    }
    
    
    //TableViewDelegate DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tblViewMain.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        cell.selectionStyle = .none;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblViewMain.isHidden = true;
        let fr = CGRect.init(x: touchPoint.x-10, y: touchPoint.y-10, width: 20, height: 20)
        let DynamicView = UIView(frame:fr)
        DynamicView.backgroundColor=UIColor.green
        DynamicView.layer.cornerRadius=5
        DynamicView.layer.borderWidth=2
        carView.addSubview(DynamicView)
    }
    
    // CollectionViewDelegate DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }

    func collectionView(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImgCell = collViewMain.dequeueReusableCell(withReuseIdentifier: "ImgCell", for: indexPath) as! ImgCell
        cell.btnDelete.tag = indexPath.row;
        cell.btnDelete.addTarget(self, action:#selector(deleteImg(sender:)), for: .touchUpInside)
        let img1 : UIImage = imgArray.object(at: indexPath.row) as! UIImage
        cell.imgMain.image = img1;
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
   
    func deleteImg(sender: UIButton){
        //...
        let aTag = sender.tag;
        if imgArray.count >= aTag {
            
            let actionSheetController: UIAlertController = UIAlertController(title: "SuperDispatch", message: "Do you want to delete the image?", preferredStyle: .alert)
            let noAction: UIAlertAction = UIAlertAction(title: "No", style: .destructive) { action -> Void in
                //Just dismiss the action sheet
            }
            let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
                self.imgArray.removeObject(at: aTag)
                self.collViewMain.reloadData()
            }
            actionSheetController.addAction(noAction)
            actionSheetController.addAction(yesAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
