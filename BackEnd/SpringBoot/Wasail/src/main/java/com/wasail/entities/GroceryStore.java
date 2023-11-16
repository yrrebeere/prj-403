package com.wasail.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "grocery_store")
public class GroceryStore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id", nullable = false)
    private Integer storeId;

    @Column(name = "name", nullable = false, length = 45)
    private String name;

    @Column(name = "store_name", nullable = false, length = 45)
    private String storeName;

    @Column(name = "store_address", nullable = false)
    private String storeAddress;

    @Column(name = "mobile_number", nullable = false, length = 11)
    private String mobileNumber;

    @Column(name = "shop_location", nullable = false)
    private String shopLocation;

    @Column(name = "password", nullable = false)
    private String password;

}