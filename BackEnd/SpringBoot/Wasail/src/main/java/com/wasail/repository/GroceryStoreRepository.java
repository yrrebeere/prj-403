package com.wasail.repository;

import com.wasail.entities.GroceryStore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GroceryStoreRepository extends JpaRepository<GroceryStore, Integer> {

}
