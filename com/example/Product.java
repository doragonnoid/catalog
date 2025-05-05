package com.example;

public class Product {
    private int id;
    private String name;
    private int categoryId;
    private String description;
    private double price;

    // Constructor
    public Product(int id, String name, int categoryId, String description, double price) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.description = description;
        setPrice(price);  // Ensuring price is set through the setter for validation
    }

    // Getter Methods
    public int getId() { return id; }
    public String getName() { return name; }
    public int getCategoryId() { return categoryId; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }

    // Setter Methods
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(double price) {
        if (price >= 0) {
            this.price = price;
        } else {
            System.out.println("Price cannot be negative.");
        }
    }

    // Display Method
    public void display() {
        System.out.println(this);
        System.out.println("-------------------------------");
    }

    // Override toString() for better printing
    @Override
    public String toString() {
        return "ID: " + id + "\n" +
                "Name: " + name + "\n" +
                "Category ID: " + categoryId + "\n" +
                "Description: " + description + "\n" +
                "Price: $" + price;
    }

    public static void main(String[] args) {
        // Example usage
        Product product = new Product(1, "Laptop", 101, "High-performance laptop", 799.99);
        product.display();  // Displays the product details
    }
}
