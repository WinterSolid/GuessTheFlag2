//
//  GuessTheFlag2Tests.swift
//  Created by Zakee Tan on 7/9/25.
//
import XCTest
@testable import GuessTheFlag2

final class GuessTheFlag2ViewModelTests: XCTestCase {
    var viewModel: GuessTheFlag2ViewModel!

    override func setUp() async throws {
      viewModel = await GuessTheFlag2ViewModel()
    }

    func testGenerateFlags_createsThreeOptions() async throws {
        await viewModel.generateFlags()
        let options = await viewModel.options
        XCTAssertEqual(options.count, 3, "Should generate exactly 3 options")
    }

    func testCorrectAnswerWithinBounds() async throws {
        await viewModel.generateFlags()
        let correct = await viewModel.correctAnswer
        let count = await viewModel.options.count
        XCTAssertTrue((0..<count).contains(correct), "Correct answer index must be within range")
    }

    func testCorrectAnswerShowsCorrectMessage() async throws {
        await viewModel.generateFlags()
        let correct = await viewModel.correctAnswer
        await viewModel.flagTapped(index: correct)
        let message = await viewModel.resultMessage
        let show = await viewModel.showResult
        XCTAssertTrue(message.contains("Correct"), "Message should indicate a correct answer")
        XCTAssertTrue(show, "Result popup should be visible")
    }

  func testWrongAnswerShowsWrongMessage() async throws {
         await viewModel.generateFlags()
         let correct = await viewModel.correctAnswer
         let options = await viewModel.options
         guard let wrong = (0..<options.count).first(where: { $0 != correct }) else {
             XCTFail("Couldn't find a wrong index")
             return
         }
         await viewModel.flagTapped(index: wrong)
         let message = await viewModel.resultMessage
         let show = await viewModel.showResult
         XCTAssertTrue(message.contains("Wrong"), "Message should indicate a wrong answer")
         XCTAssertTrue(show, "Result popup should be visible")
     }
 }
