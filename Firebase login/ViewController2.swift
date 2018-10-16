
import UIKit
import FirebaseAuth

class ViewController2: UIViewController, UITableViewDataSource {
    
    
    
    @IBOutlet weak var countrylisttable: UITableView!
    
    
    

    var fetchedcountry = [Country]()
  
    @IBAction func action(_ sender: UIButton) {
   
        try! Auth.auth().signOut()
       performSegue(withIdentifier: "segue2", sender: self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countrylisttable.dataSource = self
        
        datacountry()

        }
    
    
    override var prefersStatusBarHidden: Bool {
        
        return true
   
    }
    
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedcountry.count
    }
    
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = countrylisttable.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = fetchedcountry[indexPath.row].country
        
    return cell!
        
        
        }

    
    
    
    func datacountry() {
        
        fetchedcountry = []
        
        
        
        let url = "https://restcountries.eu/rest/v2/all?fields=name;"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        

        
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if (error != nil)
            
            {
                print("Error")
                
            }
            else{
                
                do{

                    let fetcheddata = try JSONSerialization.jsonObject(with: data! , options:.mutableLeaves )
                    as! NSArray
                    

                    for eachfetchedcountry in fetcheddata {
                        
                        
                        let eachcountry = eachfetchedcountry as! [String : Any]
                        let country = eachcountry["name"] as! String
                        
                        self.fetchedcountry.append(Country(country: country))
                        
                   }
 
                    
                    self.countrylisttable.reloadData()
                    
                    
                    }
            
                catch {
                    
                    print("there is an error")
                    
                }
            }
        }
       
                task.resume()
        
    }

    
    class Country {
    
        var country : String
        
        init(country : String) {
            self.country=country
            
        }
       }

}



