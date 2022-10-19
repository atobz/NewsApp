import UIKit
import Foundation
import SnapKit


class FirstViewController: UIViewController {
    var teslaArticles = [Article]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    //-XMARK: ----------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My First VC"
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        self.tabBarItem = tabBarItem
        self.view.backgroundColor = UIColor.yellow
        
        let teslaLastMonth = "https://newsapi.org/v2/everything?q=tesla&from=2022-09-19&sortBy=publishedAt&apiKey=96b5012e0d9d4f21ad04f572f1233295"
        DispatchQueue.main.async {
            self.getData5(URL: teslaLastMonth) { result in
            print (result[0].title)
            self.teslaArticles = result
            print(self.teslaArticles[2].title)
            self.tableView.reloadData()
            
        }
        }
        
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        [tableView].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview()
        }
        

        
    }
    
    func getData5(URL url:String, completion: @escaping ([Article]) -> ()) {
        print ("function getData started 0")
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if let error = error{
                print (error)
                return
            }
            guard let data = data else {return}
            do {
                let parsingData = try JSONDecoder().decode(News.self, from: data)
                let parsedArticles =  parsingData.articles
                completion(parsedArticles)
            } catch {
                print ("error is \(error), and response: \(response)")
                print ("Parsing error")
            }
        }
            .resume()
        
        
    }
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teslaArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as? LinkTableViewCell
        else{
            return UITableViewCell()
            
        }
        
        cell.configure(model: teslaArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

