package com.devops.hotel.Impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.hotel.entity.Hotel;
import com.devops.hotel.exception.ResourceNotFoundException;
import com.devops.hotel.repositories.HotelRepository;
import com.devops.hotel.services.HotelService;


@Service
public class HotelServiceImpl implements HotelService {

    @Autowired
    private HotelRepository hotelRepository;

    @Override
    public Hotel create(Hotel hotel) {
        String hotelId = UUID.randomUUID().toString();

        hotel.setHotelId(hotelId);
        return hotelRepository.save(hotel);
    }

    @Override
    public List<Hotel> getAll() {
        return hotelRepository.findAll();
    }

    @Override
    public Hotel getHotel(String Id) {
        return hotelRepository.findById(Id).orElseThrow(() -> new ResourceNotFoundException("Hotel with given Id not found..."));
    }

}
