package com.devops.hotel.exception;

public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(){
        super("Hotel with given Id not found");
    }

    public ResourceNotFoundException(String message){
        super(message);
    }
}
