package com.devops.hotel.services;

import java.util.List;

import com.devops.hotel.entity.Hotel;

public interface HotelService {
    // create

    Hotel create(Hotel create);

    //getAll
    List<Hotel> getAll();

    //get Single hotel info

    Hotel getHotel(String Id);
}
