package com.wasail.service;

import com.wasail.entities.GroceryStore;
import com.wasail.repository.GroceryStoreRepository;
import org.springframework.stereotype.Service;

@Service
public class GroceryStoreService {
    private final GroceryStoreRepository groceryStoreRepository;

    public GroceryStoreService(GroceryStoreRepository groceryStoreRepository) {
        this.groceryStoreRepository = groceryStoreRepository;
    }

    public GroceryStore saveGroceryStore(GroceryStore groceryStore) {
        return groceryStoreRepository.save(groceryStore);
    }

    public GroceryStore getGroceryStoreById(Integer storeId) {
        return groceryStoreRepository.findById(storeId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid Store ID" + storeId));
    }

    public Iterable<GroceryStore> getAllGroceryStores() {
        return groceryStoreRepository.findAll();
    }

    public void deleteGroceryStoreById(Integer storeId) {
        groceryStoreRepository.deleteById(storeId);
    }

}
