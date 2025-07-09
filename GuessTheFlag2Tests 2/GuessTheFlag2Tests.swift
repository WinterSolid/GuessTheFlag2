//
//  GuessTheFlag2ViewModelTests.swift
//  GuessTheFlag2ViewModelTests
//
//  Created by Zakee Tan on 7/9/25.
//

import XCTest
@testable import GuessTheFlag2


final class GuessTheFlag2Tests: XCTestCase {
    var viewModel: GuessTheFlag2ViewModel!

    override func setUpWithError() throws {
        viewModel = GuessTheFlag2ViewModel()
    }

    func testGenerateFlags_createsThreeOptions() async throws {
        await viewModel.generateFlags()
        XCTAssertEqual(viewModel.options.count, 3, "Should have exactly 3 options")
    }

    func testCorrectAnswerWithinBounds() async throws {
        await viewModel.generateFlags()
        XCTAssertTrue((0..<viewModel.options.count).contains(viewModel.correctAnswer),
                      "Correct answer index must be within bounds")
    }

    func testFlagTapped_correctAnswerShowsCorrectMessage() async throws {
        await viewModel.generateFlags()
        let correctIndex = viewModel.correctAnswer

        await viewModel.flagTapped(index: correctIndex)

        XCTAssertTrue(viewModel.resultMessage.contains("Correct"),
                      "Message should indicate a correct answer")
        XCTAssertTrue(viewModel.showResult, "Result popup should be visible")
    }

    func testFlagTapped_wrongAnswerShowsWrongMessage() async throws {
        await viewModel.generateFlags()

        let wrongIndex = (0..<viewModel.options.count).first { $0 != viewModel.correctAnswer }!

        await viewModel.flagTapped(index: wrongIndex)

        XCTAssertTrue(viewModel.resultMessage.contains("Wrong"),
                      "Message should indicate a wrong answer")
        XCTAssertTrue(viewModel.showResult, "Result popup should be visible")
    }
}
