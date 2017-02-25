
import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    
    @IBOutlet weak var collViewMain: UICollectionView!
//    var imgArray = NSMutableArray ()
    
    class func initViewController() -> PhotosViewController  {
        let controller = PhotosViewController(nibName: "PhotosViewController", bundle: nil)
        controller.title = "Photos"
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collViewMain.register(UINib(nibName: "ImgCell", bundle: nil), forCellWithReuseIdentifier: "ImgCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collViewMain.reloadData()
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
                imgArray.removeObject(at: aTag)
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
