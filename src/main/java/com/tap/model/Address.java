
package com.tap.model;

public class Address {

	private int addressID;
	private int userID;

	private String addressType; // Home, Work, Other

	private String fullName;

	private String phone;

	private String houseNo;

	private String area;

	private String city;

	private String state;

	private String pincode;

	private String landmark;

	private boolean isDefault;

	// Default Constructor
	public Address() {

	}

	// Parameterized Constructor
	public Address(int addressID, int userID, String addressType, String fullName, String phone, String houseNo,
			String area, String city, String state, String pincode, String landmark, boolean isDefault) {

		this.addressID = addressID;
		this.userID = userID;
		this.addressType = addressType;
		this.fullName = fullName;
		this.phone = phone;
		this.houseNo = houseNo;
		this.area = area;
		this.city = city;
		this.state = state;
		this.pincode = pincode;
		this.landmark = landmark;
		this.isDefault = isDefault;
	}

	public int getAddressID() {
		return addressID;
	}

	public void setAddressID(int addressID) {
		this.addressID = addressID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getAddressType() {
		return addressType;
	}

	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHouseNo() {
		return houseNo;
	}

	public void setHouseNo(String houseNo) {
		this.houseNo = houseNo;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getLandmark() {
		return landmark;
	}

	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}

	public boolean getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}

	@Override
	public String toString() {
		return "Address [addressID=" + addressID + ", userID=" + userID + ", addressType=" + addressType + ", fullName="
				+ fullName + ", phone=" + phone + ", houseNo=" + houseNo + ", area=" + area + ", city=" + city
				+ ", state=" + state + ", pincode=" + pincode + ", landmark=" + landmark + ", isDefault=" + isDefault
				+ "]";
	}

}