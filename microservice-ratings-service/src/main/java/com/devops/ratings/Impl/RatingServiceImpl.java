package com.devops.ratings.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.ratings.entities.Ratings;
import com.devops.ratings.repositories.RatingRepository;
import com.devops.ratings.services.RatingService;


@Service
public class RatingServiceImpl implements RatingService{


    @Autowired
    private RatingRepository ratingRepository;

    @Override
    public Ratings create(Ratings ratings) {

        return ratingRepository.save(ratings);
       
    }

    @Override
    public List<Ratings> getRatings() {
       return ratingRepository.findAll();
    }

    @Override
    public List<Ratings> getRatingByUserID(String userId) {
        return ratingRepository.findByUserId(userId);
    }

    @Override
    public List<Ratings> getRatingByHotelID(String hotelId) {
        return ratingRepository.findByHotelId(hotelId);
    }
    
} 
