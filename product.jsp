<%@ page import="java.util.List" %>
<%@ page import="com.example.Product" %>
<%@ page import="com.example.ProductService" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Catalog</title>
</head>
<body>
    <h1>Product Catalog</h1>
    <%
        ProductService productService = new ProductService();
        List<Product> products = productService.getAllProducts();
        for (Product product : products) {
    %>
        <div style="margin-bottom:20px;">
            <p><strong>ID:</strong> <%= product.getId() %></p>
            <p><strong>Name:</strong> <%= product.getName() %></p>
            <p><strong>Category:</strong> <%= product.getCategoryId() %></p>
            <p><strong>Description:</strong> <%= product.getDescription() %></p>
            <p><strong>Price:</strong> $<%= product.getPrice() %></p>
            <hr>
        </div>
    <%
        }
    %>
</body>
</html>
