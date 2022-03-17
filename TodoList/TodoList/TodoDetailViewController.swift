//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by Jae kwon Choi on 2022/01/14.
//

import UIKit
import CoreData

//weak로 할꺼면 AnyObject타입으로 해야한다.
protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveDate()
}


class TodoDetailViewController: UIViewController {
    
    weak var delegate: TodoDetailViewControllerDelegate?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedTodoList: TodoList?
    
    var priority: PrioirtyLevel?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //데이터가 눌린게있으면
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            priority = PrioirtyLevel(rawValue: hasData.prioirtyLevel)
            makePriorityButtonDesign()
            
            deleteButton.isHidden = false
            saveButton.setTitle("update", for: .normal)
        } else {
            deleteButton.isHidden = true
            saveButton.setTitle("save", for: .normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highButton.layer.cornerRadius = highButton.bounds.height / 2
    }

    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
            
        default:
            break
        }
        
        makePriorityButtonDesign()
        
    }
    
    func makePriorityButtonDesign() {
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch self.priority {
        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
            
        default:
            break
        }
    }
    
    
    @IBAction func saveTodo(_ sender: Any) {
        
        if selectedTodoList != nil {
            updateTodo()
        } else {
            saveTodo()
        }
        
        delegate?.didFinishSaveDate()
        //화면 내리기
        self.dismiss(animated: true, completion: nil)
    }
    func saveTodo() {
        //엔티티에 저장하는 방법
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        //키벨류로가져오겠다
        guard let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else {
            return
        }
        
        //텍스트필드에입력한값가져오기
        object.title = titleTextField.text
        //저장하는순간날짜넣기
        object.date = Date()
        //개인고유번호를 주겠다. 중복되지않기 위해서
        object.uuid = UUID()
        //색상저장
        object.prioirtyLevel = priority?.rawValue ?? PrioirtyLevel.level1.rawValue
        
        //저장하겠다.
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
    
    func updateTodo() {
        
        guard let hasData = selectedTodoList else {
            return
        }
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        //지정한것만가져올려면
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedDate = try context.fetch(fetchRequest)
            
            loadedDate.first?.title = titleTextField.text
            loadedDate.first?.date = Date()
            loadedDate.first?.prioirtyLevel = self.priority?.rawValue ?? PrioirtyLevel.level1.rawValue
            
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.saveContext()
            
        } catch {
            print(error)
        }

    }
    
    @IBAction func deleteTodo(_ sender: UIButton) {
        guard let hasData = selectedTodoList else {
            return
        }
        
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        guard let hasUUID = hasData.uuid else {
            return
        }
        
        //지정한것만가져올려면
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUUID as CVarArg)
        
        do {
            let loadedDate = try context.fetch(fetchRequest)
            
            if let loadFirstData = loadedDate.first {
                context.delete(loadFirstData)
                
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.saveContext()
                
            }

            
        } catch {
                print(error)
        }
        
        delegate?.didFinishSaveDate()
        //화면 내리기
        self.dismiss(animated: true, completion: nil)
    
    }
    
}
