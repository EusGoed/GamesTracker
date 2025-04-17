//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Testing
@testable import GamesTracker

struct IGDBQueryTests {
    
    @Test func fields() {
        let query = IGDBQuery().fields(["name", "rating", "url"])
        #expect(query == "fields name,rating,url;")
    }
    
    @Test func filters() {
        let query = IGDBQuery().filters(["rating > 80", "rating_count > 100"])
        #expect(query == "where rating > 80 & rating_count > 100;")
    }
    
    @Test func sort() {
        let query = IGDBQuery().sort("rating desc")
        #expect(query == "sort rating desc;")
    }
    
    @Test func limit() {
        let query = IGDBQuery().limit(50)
        #expect(query == "limit 50;")
    }
    
    @Test func offset() {
        let query = IGDBQuery().offset(25)
        #expect(query == "offset 25;")
    }
    
    @Test func fullQuery() {
        let query = IGDBQuery()
            .fields(["name", "rating"])
            .filters(["rating > 80"])
            .sort("rating desc")
            .limit(10)
            .offset(5)
        
        #expect(query == "fields name,rating;where rating > 80;sort rating desc;limit 10;offset 5;")
    }
}
