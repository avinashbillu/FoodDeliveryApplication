package com.tap.DAO;

import java.util.List;
import com.tap.model.Address;

public interface AddressDAO {

    void addAddress(Address address);
    Address getAddress(int addressID);
    List<Address> getAddressesByUserId(int userID);
    void updateAddress(Address address);
    void deleteAddress(int addressID);
    void setDefaultAddress(int addressID, int userID);
    void clearDefaultAddress(int userID);
    Address getDefaultAddress(int userID);
}