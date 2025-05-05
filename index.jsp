<%@ page import="java.util.List" %>
<%@ page import="com.example.ProductService" %>
<%@ page import="com.example.Product" %>
<%
    List<Product> products = null;
    String errorMessage = null;
    String action = request.getParameter("action");  // Mendapatkan aksi yang dipilih
    int categoryId = -1;
    double maxPrice = -1;
    int productId = -1;

    try {
        // Membuat instance ProductService untuk mengambil data produk
        ProductService productService = new ProductService();
        
        // Memilih aksi berdasarkan parameter
        if ("viewAll".equals(action)) {
            products = productService.getAllProducts();
        } else if ("filterCategory".equals(action)) {
            // Filter berdasarkan kategori
            String categoryIdStr = request.getParameter("categoryId");
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                    if (categoryId <= 0) {
                        errorMessage = "ID kategori tidak valid. Harus lebih besar dari 0.";
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "ID kategori tidak valid.";
                }
            } else {
                errorMessage = "ID kategori tidak ditemukan.";
            }
            if (errorMessage == null && categoryId != -1) {
                products = productService.getProductsByCategory(categoryId);
            }
        } else if ("filterPrice".equals(action)) {
            // Filter berdasarkan harga
            String maxPriceStr = request.getParameter("maxPrice");
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(maxPriceStr);
                } catch (NumberFormatException e) {
                    errorMessage = "Harga tidak valid.";
                }
            }
            if (errorMessage == null && maxPrice >= 0) {
                products = productService.getProductsByPrice(maxPrice);
            }
        } else if ("viewDetail".equals(action)) {
            // Melihat detail produk berdasarkan ID
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                try {
                    productId = Integer.parseInt(productIdStr);
                    if (productId < 0) {
                        errorMessage = "ID produk tidak valid. Harus lebih besar dari 0.";
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "ID produk tidak valid.";
                }
            } else {
                errorMessage = "ID produk tidak ditemukan.";
            }
            if (errorMessage == null && productId != -1) {
                Product product = productService.getProductDetail(productId);
                if (product != null) {
                    products = java.util.Arrays.asList(product);
                } else {
                    errorMessage = "Produk dengan ID " + productId + " tidak ditemukan.";
                }
            }
        } else {
            // Default menampilkan semua produk jika tidak ada aksi
            products = productService.getAllProducts();
        }

    } catch (Exception e) {
        errorMessage = "Terjadi kesalahan saat memuat produk: " + e.getMessage();
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>

<html>
<head>
    <title>Product Catalog</title>
</head>
<body>
    <h1>Product Catalog</h1>

    <% if (errorMessage != null) { %>
    <p style="color:red;"><%= errorMessage %></p>  <!-- Menampilkan pesan error -->
<% } else { %>
    <hr>
    <p>Jumlah produk ditemukan: <%= (products != null ? products.size() : 0) %></p>

    <% if (products != null) { %>
        <% for (Product product : products) { %>
            <div style="margin-bottom:20px;">
                <p><strong>ID:</strong> <%= product.getId() %></p>
                <p><strong>Name:</strong> <%= product.getName() %></p>
                <p><strong>Category ID:</strong> <%= product.getCategoryId() %></p>
                <p><strong>Description:</strong> <%= product.getDescription() %></p>
                <p><strong>Price:</strong> $<%= product.getPrice() %></p>
                <hr>
            </div>
        <% } %>
    <% } %>
<% } %>

    <form method="get" action="index.jsp">
        <label for="action">Choose action: </label>
        <select name="action" onchange="this.form.submit()">
            <option value="viewAll">View All Products</option>
            <option value="filterCategory">Filter by Category</option>
            <option value="filterPrice">Filter by Max Price</option>
            <option value="viewDetail">View Product Detail</option>
        </select>
    </form>

    <hr>

    <% if ("filterCategory".equals(action)) { %>
        <form method="get" action="index.jsp">
            <input type="hidden" name="action" value="filterCategory">
            <label for="categoryId">Category ID: </label>
            <input type="number" name="categoryId" value="<%= categoryId != -1 ? categoryId : "" %>" required>
            <input type="submit" value="Filter">
        </form>
    <% } %>

    <% if ("filterPrice".equals(action)) { %>
        <form method="get" action="index.jsp">
            <input type="hidden" name="action" value="filterPrice">
            <label for="maxPrice">Max Price: </label>
            <input type="number" step="0.01" name="maxPrice" required>
            <input type="submit" value="Filter">
        </form>
    <% } %>

    <% if ("viewDetail".equals(action)) { %>
        <form method="get" action="index.jsp">
            <input type="hidden" name="action" value="viewDetail">
            <label for="productId">Product ID: </label>
            <input type="number" name="productId" required>
            <input type="submit" value="View Detail">
        </form>
    <% } %>

</body>
</html>
