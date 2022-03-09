//
//  ViewController.swift
//  Rest API
//
//  Created by Gevorg Hovhannisyan on 06.10.21.
//

import UIKit

class ViewController: UIViewController  {
    
    
    private let apiCaller = APICaller()
    
    var users: [User] = []
    var pageNumber = 1
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        return tableView
        
    }()
    
    private var data = [String]()
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    
    func getUsers() {
        
        //MARK: - API EndPoint
        let urlString = "https://randomuser.me/api/?page=\(pageNumber)&result=20"
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            debugPrint("URL Is nil")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { ( data, respose, error ) in
            if error == nil && data != nil {
                
                //Pars JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    let newUsers = try decoder.decode([User].self, from: data!)
                    self.users.append(contentsOf: newUsers)
                    dump(newUsers)
                    print("This is JSON result -->\(newUsers)")

                    
                } catch {
                    
                    debugPrint("Error is JSON parsing!")
                    print()
                }
            }
        }
        
        //MARK: - API Call
        dataTask.resume()
    }
        
    //MARK: - LayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        apiCaller.fetchData(pagination: false, complation: { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    
                    self?.tableView.reloadData()
                }
                case .failure(_):
                break
            }
        })
    }
    
    //MARK: - Spiner Footer
    
    private func createSpinerFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            guard !apiCaller.isPaginating else{
                
                return
            }
            
            self.tableView.tableFooterView = createSpinerFooter()
            
            apiCaller.fetchData(pagination: true) { [weak self] result in
                
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                switch result {
                case . success(let moreData):
                    self?.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
}

//MARK: - EXTENSIONS
extension ViewController: UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if users.count - 2 == indexPath.row {
            pageNumber += 1
            getUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
