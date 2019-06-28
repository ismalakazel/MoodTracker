import XCTest
@testable import MoodTracker


class MoodModelControllerTests: XCTestCase {
    
    // MARK: - Private Property

    private var model: MoodModelController!
    private let container = PersistentContainer(name: "Model", store: .memory)
    
    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProcotol.self]
        model = MoodModelController(container: container, session: URLSession(configuration: configuration))
    }
    
    override func tearDown() { }
    
    // MARK: - Test Cases

    func testFetchQuestionFromWebService() {
        let expect = expectation(description: "Expect to fetch question from web service")
        
        MockURLProcotol.block = { request in
            let status = Status.ok.rawValue
            let response = MockURLProcotol.loadJSONResponse(with: "get_question")
            return (status, response)
        }
        
        model.fetchQuestion { question in
            XCTAssertNotNil(question)
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
    
    func testSaveQuestionAndAnswer() {
        let answer = AnswerResponse(id: 1, text: "my answer", weight: 1)
        model.save(answerResponse: answer, and: "my question")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            let answers = Answer.fetch(in: self.container.viewContext)
            XCTAssert(answers.count > 0)
        }
    }
}
