package com.devops.ratings.entities;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "ratings-db")
public class Ratings{

    
    @Id
    private String ratingId;
    private String userId;
    private String hotelId;
    private int ratings;
    private String feedback;
}
