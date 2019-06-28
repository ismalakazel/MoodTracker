import CoreData


class MoodModelController {
    
    // MARK: - Private Property
    
    private let queue = OperationQueue()
    private var saveContext: NSManagedObjectContext!
    
    // MARK: - Initializer
    
    init(container: PersistentContainer) {
        saveContext = container.newBackgroundContext()
    }
    
    // MARK: - Public Methods

    func fetchQuestion(completionHandler: @escaping (QuestionResponse) -> ()) {
        Request<QuestionRoute, QuestionResponse>(route: .list).perform { result in
            if case .success(let response) = result {
                completionHandler(response)
            }
        }
    }
    
    func save(answerResponse: AnswerResponse, and questionString: String) {
        saveContext.performChanges {
            
            let answerPredicate = NSPredicate(format: "id = %i", answerResponse.id)
            let answer = Answer.findOrCreate(in: self.saveContext, matching: answerPredicate) { answer in
                answer.text = answerResponse.text
                answer.weight = Int16(answerResponse.weight)
                answer.lid = UUID()
                answer.date = Date()
            }

            
            let questionPredicate = NSPredicate(format: "text = %@", questionString)
            let question = Question.findOrCreate(in: self.saveContext, matching: questionPredicate) { question in
                question.text = questionString
                question.date = Date()
            }
            
            answer.question = question
            question.answers.adding(answer)
        }
    }
}
