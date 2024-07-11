//
//  RemindersListViewModelTests.swift
//  Next callsTests
//
//  Created by Yoeri Van Damme on 11/07/2024.
//

import XCTest
@testable import Next_calls

final class CallListViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNoPhoneNumbers() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let input : [Reminder] = [
            Reminder(title: "no phone number"),
            Reminder(title: "no phone number 1"),
            Reminder(title: "no phone number 23"),
        ]
        let sut = NextCallListViewModel(reminders: input, contacts: [])
        assert(sut.calls.count == 0)
    }
    
    func testExtractPhoneNumber() throws {
        let testCases: [(input: String, expected: String)] = [
            // be (mobile)
            ( "Item +32 477 40 30 40", "+32477403040"),
            ( "Item 0477 40 30 40", "0477403040"),
            ( "Item +32477403040", "+32477403040"),
            ( "Item 0477403040", "0477403040"),
            // be (landline)
            ( "Item 037700304", "037700304"),
            ( "Item 03 770 03 04", "037700304"),
            // nl (mobile)
            ( "Item +31 6 11223199", "+31611223199"),
            ( "Item +31611223199", "+31611223199"),
            ( "Item 0 6 11223199", "0611223199"),
            ( "Item 0611223199", "0611223199"),
            // contacts
            ("Bellen met Joske Vermeulen", "+32477885566"),
            ("Bellen met joske vermeulen", "+32477885566")
        ]
        
        let contacts = [
            Contact(
                indexes: ["Joske Vermeulen", "Joske, Vermeulen", "Vermeulen Joske", "Vermeulen, Joske"],
                phone: Phone(description: "test", number: "+32 477 88 55 66")
            )
        ]
        
        
        for (input, expected) in testCases {
            let sut = NextCallListViewModel(reminders: [Reminder(title: input)],contacts: contacts)
            let result = sut.calls.first?.phone
            XCTAssertEqual(result, expected, "Failed for input: \(input)")
        }
    }
    
    
    
}
