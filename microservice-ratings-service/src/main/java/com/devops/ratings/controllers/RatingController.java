package com.devops.ratings.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.devops.ratings.entities.Ratings;
import com.devops.ratings.services.RatingService;

@RestController
@RequestMapping("/ratings")
public class RatingController {

    @Autowired
    RatingService ratingService;

    // create rating
    @PostMapping
    public ResponseEntity<Ratings> create(@RequestBody Ratings rating) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ratingService.create(rating));

    }

    // get all ratings
 @GetMapping
    public ResponseEntity<List<Ratings>> getRatings() {
        return ResponseEntity.ok(ratingService.getRatings());
    }

    // get ratigns by user id
    @GetMapping("/users/{userId}")
    public ResponseEntity<List<Ratings>> getRatingByUserId(@PathVariable String userId) {
        return ResponseEntity.ok(ratingService.getRatingByUserID(userId));
    }

    // get ratigns by Hotel id
    @GetMapping("/hotels/{hotelId}")
    public ResponseEntity<List<Ratings>> getRatingByHotelId(@PathVariable String hotelId) {
        return ResponseEntity.ok(ratingService.getRatingByHotelID(hotelId));
    }

}
