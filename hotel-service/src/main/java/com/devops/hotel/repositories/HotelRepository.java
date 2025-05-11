package com.devops.hotel.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.devops.hotel.entity.Hotel;

public interface HotelRepository extends JpaRepository<Hotel,String>{
    
}
