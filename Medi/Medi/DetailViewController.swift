//
//  DetailViewController.swift
//  Medi
//
//  Created by 황정호 on 2021/08/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memoTableVeiw: UITableView!
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    
    var memo: Memo?
    
    @IBAction func deleteMemo(_ sender: Any) {
        let altert = UIAlertController(title: "추억의 회상", message: "시간이 지나도 변하지 않는 가치는 소중합니다.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "지워", style: .destructive) { action  in
            DataManager.shared.deleteMemo(self.memo)
            self.navigationController?.popViewController(animated: true)
        }
        altert.addAction(deleteAction)
        
        let cancleAction = UIAlertAction(title: "지우지마", style: .cancel,handler: nil)
        altert.addAction(cancleAction)
        
        present(altert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController{
            vc.editTarget = memo
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoTableVeiw.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            
            cell.textLabel?.text = memo?.content
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            
            return cell
        default:
            fatalError()
        }
    }
    
    
    
}
