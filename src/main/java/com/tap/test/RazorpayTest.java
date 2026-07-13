package com.tap.test;

import com.razorpay.RazorpayClient;

public class RazorpayTest {

    public static void main(String[] args) {

        try {

            RazorpayClient client =
                    new RazorpayClient(
                            "rzp_test_TCUsTW2C16cyoP",
                            "jNoOFO9iVEovIMDisRIBXlvW");

            System.out.println("Razorpay SDK Loaded Successfully");

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}