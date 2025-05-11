package com.devops.ratings.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.devops.ratings.entities.Ratings;
import java.util.List;


public interface RatingRepository extends MongoRepository<Ratings, String>{

    //custom finder methods
    List<Ratings> findByUserId(String userId);


    List<Ratings> findByHotelId(String hotelId);
    
}
