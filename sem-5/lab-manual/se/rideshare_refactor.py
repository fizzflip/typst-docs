import os
import re

# We will apply these replacements in order.
# Using word boundaries where appropriate to avoid partial replacements.
replacements = [
    # Global Platform Names
    (r"ShopNex Enterprise E-Commerce Platform", "SwiftRide Enterprise Ride-Sharing Platform"),
    (r"ShopNex E-Commerce Platform", "SwiftRide Ride-Sharing Platform"),
    (r"ShopNex Web Platform", "SwiftRide Web Platform"),
    (r"ShopNex", "SwiftRide"),
    (r"\be-commerce\b", "ride-sharing"),
    (r"\bE-Commerce\b", "Ride-Sharing"),
    (r"e-commerce portal", "ride-sharing platform"),
    (r"shopping carts", "active ride requests"),
    
    # Practical 2: SRS
    (r"browse categorized products", "request rides with different vehicle types"),
    (r"maintain persistent shopping carts", "maintain active ride sessions"),
    (r"execute multi-gateway payments", "execute secure fare payments"),
    (r"track shipments", "track driver locations live"),
    (r"catalogs and inventories", "fleets and drivers"),
    (r"Product Catalog & Search", "Driver Matching & ETA"),
    (r"catalog search", "driver search"),
    (r"full-text indexed multi-faceted filtering by category, price, brand, and customer ratings", "geospatial indexing and driver filtering by vehicle type, ETA, and driver ratings"),
    (r"Cart & Session State", "Ride Booking & Session State"),
    (r"persistent shopping cart state", "active ride request state"),
    (r"atomic inventory lock upon checkout", "atomic driver assignment lock upon booking"),
    (r"Order & Tracking Pipeline", "Trip & Tracking Pipeline"),
    (r"courier partner logistics APIs", "mapping and routing APIs"),
    (r"Admin Catalog Management", "Admin Fleet Management"),
    (r"SKUs", "Vehicles"),
    (r"inventory batch quantities", "active driver statuses"),
    
    # Practical 3: Use Case
    (r"Shopping Cart", "Ride Booking"),
    (r"Checkout & Place Order", "Confirm & Book Ride"),
    (r"Checkout &amp; Place Order", "Confirm &amp; Book Ride"),
    (r"Payment Gateway, Inventory Service, Notification Daemon", "Payment Gateway, Dispatch Service, Notification Daemon"),
    (r"shopping cart contains at least one item in active inventory", "rider has selected a valid pickup and drop-off location"),
    (r"checkout and confirms shipping address", "booking and confirms pickup/drop-off locations"),
    (r"subtotal, taxes, shipping fee, and applies active promotions", "base fare, taxes, surge fee, and applies active promotions"),
    (r"Order confirmation invoice dispatched", "Ride receipt dispatched"),
    (r"retains cart items", "retains ride parameters"),
    (r"Inventory stock decremented; order state set to CONFIRMED", "Driver state set to OCCUPIED; ride state set to CONFIRMED"),
    (r"promotional discount logic", "promotional fare logic"),
    (r"Browse & Search Items", "Enter Drop Location"),
    (r"Browse &amp; Search Items", "Enter Drop Location"),
    (r"Manage Shopping Cart", "Select Vehicle Type"),
    (r"Manage Product Catalog", "Manage Driver Fleet"),
    (r"Track Shipment Status", "Track Driver Live"),
    (r"Apply Discount Coupon", "Apply Promo Code"),
    (r"Apply Coupon", "Apply Promo Code"),
    
    # Practical 4: Activity
    (r"Order Fulfillment Pipeline", "Ride Fulfillment Pipeline"),
    (r"Warehouse systems", "Driver systems"),
    (r"Customer Partition", "Rider Partition"),
    (r"initiates order submission from cart review", "initiates ride request from fare review"),
    (r"out-of-stock", "no-drivers-available"),
    (r"Order Processing Service", "Ride Processing Service"),
    (r"stock validation", "driver availability validation"),
    (r"If in stock", "If drivers available"),
    (r"atomic inventory lock", "atomic driver assignment lock"),
    (r"Order Service", "Ride Service"),
    (r"Warehouse Partition", "Driver Partition"),
    (r"automated packing slip, picks SKUs from warehouse bins, packages items, and attaches shipping labels", "ride request notification, navigates to pickup location, and picks up rider"),
    (r"DISPATCHED", "ON_TRIP"),

    # Practical 5: Class Diagram
    (r"\bCustomer\b", "Rider"),
    (r"\bcustomer\b", "rider"),
    (r"Customer", "Rider"),
    (r"shipping addresses, loyalty points", "saved locations, loyalty points"),
    (r"addToCart\(\)", "bookRide()"),
    (r"placeOrder\(\)", "confirmRide()"),
    (r"clearCart\(\)", "cancelRide()"),
    (r"addItem\(\)", "addStop()"),
    (r"ShoppingCart", "RideSession"),
    (r"CartItem", "RideStop"),
    (r"SKU line items with quantities and line subtotal calculations", "route waypoints and segment distance calculations"),
    (r"OrderItem", "RideSegment"),
    (r"Order", "Ride"),
    (r"Product", "Vehicle"),
    (r"price, stock inventory level, and category association", "base fare, current location, and vehicle type association"),
    
    # Practical 6: Sequence Diagram
    (r"checkout\(cart\)", "bookRide(session)"),
    (r"placeOrder\(cart, payMethod\)", "confirmRide(session, payMethod)"),
    (r"InventoryService\.reserveStock\(items\)", "DispatchService.assignDriver(location)"),
    (r"InventoryService", "DispatchService"),
    (r"reservationToken: 'RES-980'", "driverAssignment: 'DRV-980'"),
    (r"orderSuccess\(orderId\)", "rideSuccess(rideId)"),
    (r"releaseReservedStock\(token\)", "releaseDriver(assignmentId)"),
    
    # Practical 7: DFD
    (r"catalog_query", "driver_search"),
    (r"order_payload", "ride_payload"),
    (r"inventory_delta", "fleet_delta"),
    (r"category_id: int, min_price, max_price", "vehicle_type: string, max_eta, max_surge"),
    (r"items: \[{sku, qty}\], shipping_address", "stops: [{lat, lng}], drop_address"),
    (r"product_id", "vehicle_id"),
    (r"batch_no", "license_plate"),
    (r"quantity_added: int", "status: string"),
    (r"D3: Order Store", "D3: Ride Store"),
    (r"Historical order snapshots", "Historical ride snapshots"),
    (r"item line charges", "segment distance charges"),
    
    # Practical 8: ER Diagram
    (r"Orders Entity", "Rides Entity"),
    (r"Order Items Associative Table", "Ride Segments Table"),
    (r"CREATE TABLE orders", "CREATE TABLE rides"),
    (r"order_id", "ride_id"),
    (r"order_date", "ride_date"),
    (r"total_amount", "total_fare"),
    (r"order_status", "ride_status"),
    (r"CREATE TABLE order_items", "CREATE TABLE ride_segments"),
    (r"item_id", "segment_id"),
    (r"products", "vehicles"),
    (r"quantity", "distance_km"),
    (r"unit_price", "fare_per_km"),
    
    # Practical 9: CFG
    (r"calculateDiscount", "calculateFare"),
    (r"cartTotal", "distanceKm"),
    (r"hasCoupon", "hasPromo"),
    (r"discount", "surgeMultiplier"), # carefully mapping Logic
    # Let's adjust the logic textually
    (r"discount = 0.0", "surgeMultiplier = 1.0"),
    (r"discount = 0.20", "surgeMultiplier = 0.8"),
    (r"discount \+= 0.05", "surgeMultiplier -= 0.1"),
    (r"discount \+= 0.10", "surgeMultiplier -= 0.2"),
    (r"netTotal = cartTotal \* \(1.0 - discount\)", "netFare = (distanceKm * 10.0) * surgeMultiplier"),
    (r"return netTotal", "return netFare"),
    (r"Discount =", "Fare Multiplier ="),
    
    # Practical 10: Test Matrix
    (r"Order Total > \$100", "Distance > 20km"),
    (r"Coupon Code", "Promo Code"),
    (r"Apply Free Shipping", "Waive Toll Fees"),
    (r"Apply 15% Discount", "Apply 15% Promo"),
    
    # Practical 12: Blisk
    (r"3-column product showcase", "full-screen live map interface"),
    (r"persistent left filter sidebar drawer", "persistent vehicle selection drawer"),
    (r"\.product-grid", ".vehicle-list"),
    
    # Practical 13: Bug Report
    (r"Duplicate Card Charge on Payment Gateway HTTP 504 Gateway Timeout", "Duplicate Card Charge on Payment Gateway HTTP 504 Gateway Timeout"),
    (r"Checkout Payment Service", "Ride Fare Payment Service"),
    (r"Add item SKU-9021 to cart and proceed to Checkout", "Select 'Premium SUV' and proceed to Book Ride"),
    (r"Checkout Summary Modal", "Ride Summary Modal"),
    (r"coupon input field", "promo code input field"),
    (r"open checkout cart", "open ride summary"),
    
    # General terminology cleanup
    (r"StorefrontUI", "RiderAppUI"),
    (r"OrderService", "RideService"),
    
    # specific fix for SVG texts
    (r"order", "ride"),
    (r"Order", "Ride"),
    (r"orders", "rides"),
    (r"Orders", "Rides"),
    
    (r"Customer", "Rider"),
    (r"customer", "rider"),
    
    (r"Logistics Partner", "Maps API"),
]

def apply_replacements(text):
    for old, new in replacements:
        # Use regex if possible for case-insensitive or exact matches where specified,
        # but since our list mixes literal strings and regex patterns implicitly,
        # we'll use regex sub.
        text = re.sub(old, new, text)
    return text

def main():
    base_dir = "/home/mrbot/.temp/typst-docs/sem-5/lab-manual/se"
    
    for root, _, files in os.walk(base_dir):
        for file in files:
            if file.endswith('.typ') or file.endswith('.svg'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                new_content = apply_replacements(content)
                
                # Second pass for some specific SVG / leftover fixes
                new_content = new_content.replace('shopping cart', 'ride request')
                new_content = new_content.replace('Shopping cart', 'Ride request')
                new_content = new_content.replace('checkout', 'booking')
                new_content = new_content.replace('Checkout', 'Booking')
                new_content = new_content.replace('Shipment', 'Trip')
                new_content = new_content.replace('shipment', 'trip')
                new_content = new_content.replace('Cart', 'RideSession')
                
                if new_content != content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Updated {filepath}")

if __name__ == "__main__":
    main()
