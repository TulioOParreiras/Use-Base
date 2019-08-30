//
//  USE_IMDBTests.swift
//  USE_IMDBTests
//
//  Created by Usemobile on 14/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import XCTest
@testable import USE_IMDB
@testable import Alamofire
@testable import SkeletonView

class USE_IMDBTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMediaViewModel(){
        let model = MediaModel(objectId: "test01", poster: "poster01", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
                
        XCTAssertNotNil(viewModel, " nil")
    }
    
    func testDetailsViewController(){
        let model = MediaModel(objectId: "test01", poster: "poster01", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        let vc = DetailsViewController(mediaViewModel: viewModel)

        XCTAssertNoThrow(vc.loadView())
        XCTAssertNoThrow(vc.viewDidLoad())
        
        XCTAssertNoThrow(vc.playProgress())
        XCTAssertNoThrow(vc.stopProgress())
        
        XCTAssertNotNil(vc, " nil ")
        XCTAssertNotNil(vc.detailsView, " nil")
        XCTAssertNotNil(vc.view, "nil")
    }
    
    
    
    func testDetailsView(){
        let model = MediaModel(objectId: "test01", poster: "poster01", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        let vc = DetailsViewController(mediaViewModel: viewModel)
        
        XCTAssertNotNil(vc.detailsView, "details nil")
        XCTAssertNoThrow(vc.detailsView.playProgress())
        XCTAssertNoThrow(vc.detailsView.stopProgress())

    }
    
    func testSearchViewController(){
        let model = MediaModel(objectId: "test01", poster: "poster01", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        let vc = SearchViewController()
        
        let search = UISearchController()
        search.searchBar.text = "Avengers"
        
        XCTAssertNoThrow(vc.viewWillDisappear(true))
        XCTAssertNoThrow(vc.presentMediaDetails(viewModel))
        XCTAssertNoThrow(vc.updateSearchResults(for: search))
        XCTAssertNoThrow(vc.requestSearch(text: "Avengers"))

    }
    
    func testSearchView(){
        let model = MediaModel(objectId: "test01", poster: "poster01", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        
        let vc = SearchViewController()
        
        XCTAssertNotNil(vc.searchView, "search nil")
        XCTAssertEqual(vc.searchView.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertNoThrow(vc.searchView.updateViewModel([viewModel]))
        
        vc.searchView.updateViewModel([viewModel])
        vc.searchView.tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = vc.searchView.tableView.dataSource?.tableView(vc.searchView.tableView, cellForRowAt: indexPath)
        
        XCTAssertNotNil(cell?.contentView, "cell nil")
    }
    
    func testSearchCell(){
        let model = MediaModel(objectId: "test01", poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        let vc = SearchViewController()
        
        vc.searchView.updateViewModel([viewModel])
        
        let indexPath = IndexPath(row: 0, section: 0)
        let table = vc.searchView.tableView
        
        XCTAssert(table != nil)
        let cell = table?.cellForRow(at: indexPath)
        XCTAssert(cell is SearchCell)
        
        if let searchCell = cell as? SearchCell {
            XCTAssertEqual(searchCell.lblYear.text, "2000")
            XCTAssertEqual(searchCell.lblType.text, "type01")
            XCTAssertEqual(searchCell.lblTitle.text, "titulo01")
            XCTAssertTrue(searchCell.imvPoster.image != nil)
        } else {
            XCTFail("Cell does not conform with SearchCell class")
        }
        
        XCTAssert(table?.numberOfRows(inSection: 0) == 1)
    }
    
    func testTablewViewSearchView(){
        
        let model = MediaModel(objectId: "test01", poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        
        let model2 = MediaModel(objectId: "test02", poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", title: "titulo02", type: "type02", year: "2002")
        let viewModel2 = MediaViewModel(mediaModel: model2)
        
        let model3 = MediaModel(objectId: "test03", poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", title: "titulo03", type: "type03", year: "2003")
        let viewModel3 = MediaViewModel(mediaModel: model3)
        
        let model4 = MediaModel(objectId: "test04", poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", title: "titulo04", type: "type04", year: "2004")
        let viewModel4 = MediaViewModel(mediaModel: model4)
        
        let vc = SearchViewController()
        
        vc.searchView.updateViewModel([viewModel, viewModel2, viewModel3, viewModel4])
        
        XCTAssertEqual(vc.searchView.tableView.numberOfRows(inSection: 0), 4)
        
        XCTAssertNoThrow(vc.searchView.tableView(vc.searchView.tableView, didSelectRowAt: IndexPath(row: 2, section: 0)))
        XCTAssertNoThrow(vc.searchView.tableView(vc.searchView.tableView, didDeselectRowAt: IndexPath(row: 2, section: 0)))
        XCTAssertNoThrow(vc.searchView.tableView(vc.searchView.tableView, didHighlightRowAt: IndexPath(row: 1, section: 0)))
        XCTAssertNoThrow(vc.searchView.tableView(vc.searchView.tableView, didUnhighlightRowAt: IndexPath(row: 1, section: 0)))
        
        XCTAssert(vc.searchView.tableView(vc.searchView.tableView, didSelectRowAt: IndexPath(row: 322, section: 0)) == () )
    }
    
    func testDetailsViewIBOutlets(){
        
        let model = MediaModel(objectId: "test01", poster: "poster01", title: "titulo01", type: "type01", year: "2000")
        let viewModel = MediaViewModel(mediaModel: model)
        let vc = DetailsViewController(mediaViewModel: viewModel)
        
        vc.detailsView.mediaDetailsModel = MediaDetailsModel(title: "titulo01", year: "2019", rated: "9.8", realeased: "first", runtime: nil, genre: "film", director: "Usemobile", writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, poster: nil, ratings: nil, metascore: nil, imdbRating: nil, imdbVotes: nil, imdbID: nil, type: nil, dvd: nil, boxOffice: nil, production: nil, Website: "www.film.com", Response: nil)
        
        XCTAssertTrue(vc.detailsView.lblTitle.text == "titulo01")
        
    }
    
//    func testRequest(){
//
//        let expectation = self.expectation(
//            description: "Service succeded serializing response to GNTransactionModel array.")
//        let task = GNRemote.incomings { response in
//            if response.isSuccess {
//                expectation.fulfill()
//            }
//        }
//        task.addPath("?page=1&limit=5")
//        task.resume()
//        self.waitForExpectations(timeout: task.timeout + 5, handler: nil)
//
//    }

}



