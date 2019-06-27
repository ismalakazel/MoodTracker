import CoreData


class MoodModelController {
    
    private let queue = OperationQueue()
    private var saveContext: NSManagedObjectContext!
    
    init(container: PersistentContainer) {
        saveContext = container.newBackgroundContext()
    }
    
    func fetch(completionHandler: @escaping (QuestionResponse) -> ()) {
        Request<QuestionRoute, QuestionResponse>(route: .list) { result in
            if case .success(let response) = result {
                completionHandler(response)
            }
        }.perform()
    }
    
    func save(answerResponse: AnswerResponse, and questionString: String) {
        saveContext.performChanges {
            let answer = Answer(moc: self.saveContext)
            answer.text = answerResponse.text
            answer.weight = Int16(answerResponse.weight)
            answer.lid = UUID()
            answer.date = Date()
            
            let question = Question(moc: self.saveContext)
            question.text = questionString
            question.id = Int16(Int.random(in: 0...100))
            question.date = Date()
        }
    }
}
