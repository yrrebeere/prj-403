package com.wasail.controller;

import com.wasail.entities.*;
import com.wasail.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/groceryStores")
public class GroceryStoreController {

    private final GroceryStoreService groceryStoreService;

    public GroceryStoreController(GroceryStoreService groceryStoreService) {
        this.groceryStoreService = groceryStoreService;
    }

    @GetMapping
    public String getAllGroceryStores(Model model) {
        Iterable<GroceryStore> groceryStores = groceryStoreService.getAllGroceryStores();
        model.addAttribute("groceryStores", groceryStores);
        return "groceryStore";
    }

    @GetMapping("/create")
    public String showGroceryStoreForm(Model model) {
        model.addAttribute("groceryStore", new GroceryStore());
        return "groceryStore-form";
    }

    @PostMapping("/create")
    public String createGroceryStore(@ModelAttribute("groceryStore") GroceryStore groceryStore,
                                             @Validated BindingResult result) {
        if (result.hasErrors()) {
            return "groceryStore-form";
        }
        groceryStoreService.saveGroceryStore(groceryStore);
        return "redirect:/groceryStores";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Integer storeId, Model model) {
        GroceryStore groceryStore = groceryStoreService.getGroceryStoreById(storeId);
        model.addAttribute("groceryStore", groceryStore);
        return "groceryStore-update";
    }

    @PostMapping("/{id}/edit")
    public String updateGroceryStore(@PathVariable("id") Integer storeId,
                                             @ModelAttribute("groceryStore") GroceryStore groceryStore) {
        groceryStore.setStoreId(storeId);
        groceryStoreService.saveGroceryStore(groceryStore);
        return "redirect:/groceryStores";
    }

    @GetMapping("/{id}/delete")
    public String deleteGroceryStore(@PathVariable("id") Integer storeId) {
        groceryStoreService.deleteGroceryStoreById(storeId);
        return "redirect:/groceryStores";
    }
}
