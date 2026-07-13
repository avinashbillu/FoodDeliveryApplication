package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.AddressDAO;
import com.tap.model.Address;
import com.tap.utility.DBConnection;

public class AddressDAOImpl implements AddressDAO {

    // ====================== SQL QUERIES ======================

    private static final String ADD_ADDRESS =
            "INSERT INTO address(UserID,AddressType,FullName,Phone,HouseNo,Area,City,State,Pincode,Landmark,IsDefault) VALUES(?,?,?,?,?,?,?,?,?,?,?)";

    private static final String GET_ADDRESS =
            "SELECT * FROM address WHERE AddressID=?";

    private static final String GET_ALL_ADDRESSES =
            "SELECT * FROM address WHERE UserID=? ORDER BY IsDefault DESC, AddressID DESC";

    private static final String UPDATE_ADDRESS =
            "UPDATE address SET AddressType=?,FullName=?,Phone=?,HouseNo=?,Area=?,City=?,State=?,Pincode=?,Landmark=? WHERE AddressID=?";

    private static final String DELETE_ADDRESS =
            "DELETE FROM address WHERE AddressID=?";

    private static final String RESET_DEFAULT =
            "UPDATE address SET IsDefault=false WHERE UserID=?";

    private static final String SET_DEFAULT =
            "UPDATE address SET IsDefault=true WHERE AddressID=?";
    
    private static final String CLEAR_DEFAULT =
    		"UPDATE address SET IsDefault = false WHERE UserID=?";
    
    private static final String GET_DEFAULT =
    		"SELECT * FROM address WHERE UserID=? AND IsDefault=1";
    
    // ====================== ADD ADDRESS ======================

    @Override
    public void addAddress(Address address) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(ADD_ADDRESS);

            pstmt.setInt(1, address.getUserID());
            pstmt.setString(2, address.getAddressType());
            pstmt.setString(3, address.getFullName());
            pstmt.setString(4, address.getPhone());
            pstmt.setString(5, address.getHouseNo());
            pstmt.setString(6, address.getArea());
            pstmt.setString(7, address.getCity());
            pstmt.setString(8, address.getState());
            pstmt.setString(9, address.getPincode());
            pstmt.setString(10, address.getLandmark());
            pstmt.setBoolean(11, address.getIsDefault());

            pstmt.executeUpdate();

        }
        catch (Exception e) {

            e.printStackTrace();

        }

    }

    // ====================== GET SINGLE ADDRESS ======================

    @Override
    public Address getAddress(int addressID) {

        Connection con = DBConnection.getConnection();

        Address address = null;

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(GET_ADDRESS);

            pstmt.setInt(1, addressID);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                address = new Address();

                address.setAddressID(rs.getInt("AddressID"));
                address.setUserID(rs.getInt("UserID"));
                address.setAddressType(rs.getString("AddressType"));
                address.setFullName(rs.getString("FullName"));
                address.setPhone(rs.getString("Phone"));
                address.setHouseNo(rs.getString("HouseNo"));
                address.setArea(rs.getString("Area"));
                address.setCity(rs.getString("City"));
                address.setState(rs.getString("State"));
                address.setPincode(rs.getString("Pincode"));
                address.setLandmark(rs.getString("Landmark"));
                address.setIsDefault(rs.getBoolean("IsDefault"));

            }

        }
        catch (Exception e) {

            e.printStackTrace();

        }

        return address;

    }
 // ====================== GET ALL USER ADDRESSES ======================

    @Override
    public List<Address> getAddressesByUserId(int userID) {

        List<Address> addresses = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(GET_ALL_ADDRESSES);

            pstmt.setInt(1, userID);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Address address = new Address();

                address.setAddressID(rs.getInt("AddressID"));
                address.setUserID(rs.getInt("UserID"));
                address.setAddressType(rs.getString("AddressType"));
                address.setFullName(rs.getString("FullName"));
                address.setPhone(rs.getString("Phone"));
                address.setHouseNo(rs.getString("HouseNo"));
                address.setArea(rs.getString("Area"));
                address.setCity(rs.getString("City"));
                address.setState(rs.getString("State"));
                address.setPincode(rs.getString("Pincode"));
                address.setLandmark(rs.getString("Landmark"));
                address.setIsDefault(rs.getBoolean("IsDefault"));

                addresses.add(address);

            }

        }
        catch (Exception e) {

            e.printStackTrace();

        }

        return addresses;

    }


    // ====================== UPDATE ADDRESS ======================

    @Override
    public void updateAddress(Address address) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(UPDATE_ADDRESS);

            pstmt.setString(1, address.getAddressType());
            pstmt.setString(2, address.getFullName());
            pstmt.setString(3, address.getPhone());
            pstmt.setString(4, address.getHouseNo());
            pstmt.setString(5, address.getArea());
            pstmt.setString(6, address.getCity());
            pstmt.setString(7, address.getState());
            pstmt.setString(8, address.getPincode());
            pstmt.setString(9, address.getLandmark());
            pstmt.setInt(10, address.getAddressID());

            pstmt.executeUpdate();

        }
        catch (Exception e) {

            e.printStackTrace();

        }

    }


    // ====================== DELETE ADDRESS ======================

    @Override
    public void deleteAddress(int addressID) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(DELETE_ADDRESS);

            pstmt.setInt(1, addressID);

            pstmt.executeUpdate();

        }
        catch (Exception e) {

            e.printStackTrace();

        }

    }


    // ====================== SET DEFAULT ADDRESS ======================

    @Override
    public void setDefaultAddress(int addressID,int userID){

        Connection con = DBConnection.getConnection();

        try{

            PreparedStatement pstmt1 =
                    con.prepareStatement(
                    "UPDATE address SET IsDefault=false WHERE UserID=?");

            pstmt1.setInt(1,userID);

            pstmt1.executeUpdate();

            PreparedStatement pstmt2 =
                    con.prepareStatement(
                    "UPDATE address SET IsDefault=true WHERE AddressID=?");

            pstmt2.setInt(1,addressID);

            pstmt2.executeUpdate();

        }
        catch(Exception e){

            e.printStackTrace();

        }

    }
    
    @Override
    public void clearDefaultAddress(int userID) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(CLEAR_DEFAULT);

            pstmt.setInt(1, userID);

            pstmt.executeUpdate();

        }
        catch(Exception e){

            e.printStackTrace();

        }

    }
    @Override
    public Address getDefaultAddress(int userID) {

        Connection con = DBConnection.getConnection();
        Address address = null;

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(GET_DEFAULT);

            pstmt.setInt(1, userID);

            ResultSet rs = pstmt.executeQuery();

            if(rs.next()){

                address = new Address();

                address.setAddressID(rs.getInt("AddressID"));
                address.setUserID(rs.getInt("UserID"));
                address.setAddressType(rs.getString("AddressType"));
                address.setFullName(rs.getString("FullName"));
                address.setPhone(rs.getString("Phone"));
                address.setHouseNo(rs.getString("HouseNo"));
                address.setArea(rs.getString("Area"));
                address.setCity(rs.getString("City"));
                address.setState(rs.getString("State"));
                address.setPincode(rs.getString("Pincode"));
                address.setLandmark(rs.getString("Landmark"));
                address.setIsDefault(rs.getBoolean("IsDefault"));

            }

        }
        catch(Exception e){
            e.printStackTrace();
        }

        return address;
    }

}