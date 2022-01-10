//
//  ViewModelTests.swift
//  TimesAppTests
//
//  Created by Dhiranjana Yadav on 24/11/21.
//

import XCTest
@testable import TimesApp

class MockNetworkRequestManager: NetworkRequestable {
    enum ResponseType {
        case error
        case success
    }
    
    var responseType: ResponseType = .error
    
    func getSectionData(completionHandler: @escaping (Results?, Error?) -> Void) {
        
        switch responseType {
        case .error:
            completionHandler(nil, NSError(domain: "testing", code: 0, userInfo: [NSLocalizedDescriptionKey:"Testing Error"]) )
        case .success:
            let t = type(of: self)
            let bundle = Bundle(for: t.self)
            let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
            let data = try! Data(contentsOf: path)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try! decoder.decode(Results.self, from: data)
            completionHandler(json, nil)
        }
        
    }
}

class ViewModelTests: XCTestCase {
    
    var systemUnderTest: NewsViewModel!
    var mockRequestManager: MockNetworkRequestManager!
    
    override func setUpWithError() throws {
        mockRequestManager = MockNetworkRequestManager()
        systemUnderTest = NewsViewModel(mockRequestManager)
    }
    
    override func tearDownWithError() throws {
        mockRequestManager = nil
        systemUnderTest = nil
    }
    
    //MARK: Initial/Empty ViewModel
    func testInitialViewModel_NumberOfSections_IsZero() {
        
        let result = systemUnderTest.numberOfSections
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testInitialViewModel_NumberOfRowsInSectionZero_IsZero() {
        
        let section = 0
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testInitialViewModel_NumberOfRowsInSectionOne_IsZero() {
        
        let section = 1
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testInitialViewModel_NumberOfRowsInSectionNegativeOne_IsZero() {
        
        let section = -1
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    //MARK: Section Data Update Errors
    func testSectionUpdateError_NumberOfSections_IsZero() {
        
        mockRequestManager.responseType = .error
        systemUnderTest.updateData(completionHandler: {})
        let result = systemUnderTest.numberOfSections
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testSectionUpdateError_NumberOfRowsInSectionZero_IsZero() {
        
        mockRequestManager.responseType = .error
        systemUnderTest.updateData(completionHandler: {})
        
        let section = 0
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testSectionUpdateError_NumberOfRowsInSectionOne_IsZero() {
        
        mockRequestManager.responseType = .error
        systemUnderTest.updateData(completionHandler: {})
        
        let section = 1
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testSectionUpdateError_NumberOfRowsInSectionNegativeOne_IsZero() {
        
        mockRequestManager.responseType = .error
        systemUnderTest.updateData(completionHandler: {})
        
        let section = -1
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    //MARK: Section Data Update Success
    func testSectionUpdateSuccess_NumberOfSections_IsGreaterThanZero() {
        
        mockRequestManager.responseType = .success
        systemUnderTest.updateData(completionHandler: {})
        let result = systemUnderTest.numberOfSections
        
        XCTAssertGreaterThan(result, 0)
        
    }
    
    func testSectionUpdateSucces_NumberOfRowsInSectionZero_IsGreaterThanZero() {
        
        mockRequestManager.responseType = .success
        systemUnderTest.updateData(completionHandler: {})
        
        let section = 0
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertGreaterThan(result, 0)
        
    }
    
    func testSectionUpdateSuccess_NumberOfRowsInSectionOne_IsZero() {
        
        mockRequestManager.responseType = .success
        systemUnderTest.updateData(completionHandler: {})
        
        let section = 1
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testSectionUpdateSuccess_NumberOfRowsInSectionNegativeOne_IsZero() {
        
        mockRequestManager.responseType = .success
        systemUnderTest.updateData(completionHandler: {})
        
        let section = -1
        let result = systemUnderTest.numberOfStories(inSection: section)
        
        XCTAssertEqual(result, 0)
        
    }
}

