import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        ProductService productService = new ProductService();
        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("=== Product Catalog ===");
            System.out.println("1. View All Products");
            System.out.println("2. Filter by Category");
            System.out.println("3. Filter by Max Price");
            System.out.println("4. View Product Detail");
            System.out.println("0. Exit");
            System.out.print("Enter choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    List<Product> products = productService.getAllProducts();
                    for (Product product : products) {
                        product.display();
                    }
                    break;
                case 2:
                    System.out.print("Enter Category ID: ");
                    int categoryId = scanner.nextInt();
                    List<Product> categoryProducts = productService.getProductsByCategory(categoryId);
                    for (Product product : categoryProducts) {
                        product.display();
                    }
                    break;
                case 3:
                    System.out.print("Enter Max Price: ");
                    double maxPrice = scanner.nextDouble();
                    List<Product> priceProducts = productService.getProductsByPrice(maxPrice);
                    for (Product product : priceProducts) {
                        product.display();
                    }
                    break;
                case 4:
                    System.out.print("Enter Product ID: ");
                    int productId = scanner.nextInt();
                    Product product = productService.getProductDetail(productId);
                    if (product != null) {
                        product.display();
                    } else {
                        System.out.println("Product not found!");
                    }
                    break;
                case 0:
                    System.out.println("Exiting program...");
                    break;
                default:
                    System.out.println("Invalid choice!");
            }
        } while (choice != 0);

        scanner.close();
    }
}
