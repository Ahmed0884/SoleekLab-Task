
import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    @IBOutlet weak var actionbutton: UIButton!

    @IBAction func action(_ sender: UIButton) {
    
        if emailtext.text != "" && passwordtext.text != "" {
            
            if segmentcontrol.selectedSegmentIndex == 0
            
            {
                
                
            Auth.auth().signIn(withEmail: emailtext.text!, password: passwordtext.text!) { (user, error) in
            
                if user != nil
                
                {
                    
                    self.performSegue(withIdentifier: "segue", sender: self)
                
                
                }
                else
                {
                    
                    if let MyError = error?.localizedDescription
                    
                    {
                        print(MyError)
                        
                    }
                    
                    else
                    {
                        print("Error")
                      }
                    
                    }
                }
            }
    else
            {
                Auth.auth().createUser(withEmail: emailtext.text! , password: passwordtext.text!) { (user, error) in

                    
                    if user != nil
                        
                  {
                        self.performSegue(withIdentifier: "segue", sender: self)
                        
                  }
                
                    else
                    {
                        
                        if let MyError = error?.localizedDescription
                        {
                            
                            print (MyError)
                        }
                        else
                        {
                            
                            print("Error")
                            
                        }
                        }
                        }
            }
            
            }
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

