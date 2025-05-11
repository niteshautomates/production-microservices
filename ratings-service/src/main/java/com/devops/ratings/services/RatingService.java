package com.devops.ratings.services;

import java.util.List;

import com.devops.ratings.entities.Ratings;

public interface RatingService {
    // create
    Ratings create(Ratings ratings);

    // get all ratings

    List<Ratings> getRatings();
    // get all rating by UserId

    List<Ratings> getRatingByUserID(String userId);

    // get rating by hotel Id
    List<Ratings> getRatingByHotelID(String hotelId);
}
