//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Testing
@testable import GamesTracker

struct IGDBQueryTests {
    
    @Test func fields() {
        // Arrange / Act
        let query = IGDBQuery().fields(["name", "rating", "url"])
        
        // Assert
        #expect(query == "fields name,rating,url;")
    }
    
    @Test func filters() {
        // Arrange / Act
        let query = IGDBQuery().filters(["rating > 80", "rating_count > 100"])
        
        // Assert
        #expect(query == "where rating > 80 & rating_count > 100;")
    }
    
    @Test func sort() {
        // Arrange / Act
        let query = IGDBQuery().sort("rating desc")
        
        // Assert
        #expect(query == "sort rating desc;")
    }
    
    @Test func limit() {
        // Arrange / Act
        let query = IGDBQuery().limit(50)
        
        // Assert
        #expect(query == "limit 50;")
    }
    
    @Test func offset() {
        // Arrange / Act
        let query = IGDBQuery().offset(25)
        
        // Assert
        #expect(query == "offset 25;")
    }
    
    @Test func fullQuery() {
        // Arrange / Act
        let query = IGDBQuery()
            .fields(["name", "rating"])
            .filters(["rating > 80"])
            .sort("rating desc")
            .limit(10)
            .offset(5)
        
        // Assert
        #expect(query == "fields name,rating;where rating > 80;sort rating desc;limit 10;offset 5;")
    }
}
