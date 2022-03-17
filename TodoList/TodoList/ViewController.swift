//
//  ViewController.swift
//  TodoList
//
//  Created by Jae kwon Choi on 2022/01/14.
//

import UIKit
import CoreData

enum PrioirtyLevel: Int64 {
    case level1
    case level2
    case level3
}

extension PrioirtyLevel {
    var color: UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    //접근하는 공식
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var todoList = [TodoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //타이틀
        self.title = "To Do List"
        self.makeNavigationBar()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        fetchData()
        todoTableView.reloadData()
    }
    
    // 처음실행할때 데이터가져오기
    func fetchData() {
        //엔티티 이름
        let fetchReqeust: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            self.todoList = try context.fetch(fetchReqeust)
        } catch {
            print(error)
        }
    
    }
    
    func makeNavigationBar() {
        //오른쪽위버튼
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        navigationItem.rightBarButtonItem = item
        //색바꾸기
        item.tintColor = .black
        
        //네비게이션바 색바꾸기
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.2)
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    @objc func addNewTodo() {
        let detailVC = TodoDetailViewController.init(nibName: "TodoDetailViewController", bundle: nil)
        // 연결
        detailVC.delegate = self
        self.present(detailVC, animated: true, completion: nil)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.topTitleLabel.text = todoList[indexPath.row].title
        
        //날짜 출력
        if let hasDate = todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            let dateString = formatter.string(from: hasDate)
            cell.dateLabel.text = dateString
        } else {
            cell.dateLabel.text = ""
        }
        
        let priority = todoList[indexPath.row].prioirtyLevel
        let priorityColor = PrioirtyLevel(rawValue: priority)?.color
        cell.prioirtyView.backgroundColor = priorityColor
        cell.prioirtyView.layer.cornerRadius = cell.prioirtyView.bounds.height / 2
        
        return cell
    }
    
    //메인화면에서 눌렀을떄 그정보가져오기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TodoDetailViewController.init(nibName: "TodoDetailViewController", bundle: nil)
        // 연결
        detailVC.delegate = self
        detailVC.selectedTodoList = todoList[indexPath.row]
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
}

extension ViewController: TodoDetailViewControllerDelegate {
    func didFinishSaveDate() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
}
