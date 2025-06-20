//
//  TVShowListViewModelTests.swift
//  TVSeriesBrowser
//
//  Created by Bruna Lanna on 19/06/25.
//

import XCTest
@testable import TVSeriesBrowser

@MainActor
final class TVShowListViewModelTests: XCTestCase {
    
    func test_loadInitialShows_success() async {
        let mockRepo = MockTVShowRepository()
        mockRepo.mockShows = [TVShow.mock(id: 1), TVShow.mock(id: 2)]
        
        let viewModel = TVShowListViewModel(repository: mockRepo)
        
        await viewModel.loadInitialShows()
        
        XCTAssertEqual(viewModel.shows.count, 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_searchShows_success() async {
        let mockRepo = MockTVShowRepository()
        mockRepo.mockSearchResult = [TVShow.mock(id: 99)]
        
        let viewModel = TVShowListViewModel(repository: mockRepo)
        viewModel.searchQuery = "search"
        
        await viewModel.searchShows()
        
        XCTAssertEqual(viewModel.shows.first?.id, 99)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadInitialShows_failure() async {
        let mockRepo = MockTVShowRepository()
        mockRepo.shouldFail = true
        
        let viewModel = TVShowListViewModel(repository: mockRepo)
        
        await viewModel.loadInitialShows()

        XCTAssertTrue(viewModel.shows.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
