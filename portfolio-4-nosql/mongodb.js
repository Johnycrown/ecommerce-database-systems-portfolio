db = db.getSiblingDB("shopsphere");

db.products_catalogue.createIndex(
    { sku: 1 },
    { unique: true }
);

db.products_catalogue.createIndex({
    category: 1,
    active: 1
});

db.products_catalogue.createIndex({
    "attributes.brand": 1
});


// Insert or update smartphone.

db.products_catalogue.updateOne(
    { sku: "GAD-PHN-001" },
    {
        $set: {
            sku: "GAD-PHN-001",
            name: "Android Smartphone",
            category: "Electronics",

            vendor: {
                vendorCode: "LGD-001",
                name: "Lagos Gadgets Ltd"
            },

            price: {
                amount: 285000,
                currency: "NGN"
            },

            active: true,

            attributes: {
                brand: "ExampleTech",
                storageGb: 128,
                colour: "black",
                network: ["4G", "5G"]
            },

            variants: [
                {
                    variantCode: "BLACK-128",
                    colour: "black",
                    storageGb: 128,
                    available: true
                }
            ],

            updatedAt: new Date()
        }
    },
    { upsert: true }
);


// Insert or update blender.

db.products_catalogue.updateOne(
    { sku: "HOME-BLD-001" },
    {
        $set: {
            sku: "HOME-BLD-001",
            name: "Blender",
            category: "Home Appliances",

            vendor: {
                vendorCode: "NHS-001",
                name: "Naija Home Store"
            },

            price: {
                amount: 65000,
                currency: "NGN"
            },

            active: true,

            attributes: {
                brand: "KitchenPro",
                powerWatts: 600,
                capacityLitres: 1.5
            },

            updatedAt: new Date()
        }
    },
    { upsert: true }
);


// Find active electronics with 128GB storage.

db.products_catalogue.find({
    category: "Electronics",
    active: true,
    "attributes.storageGb": 128
});


// Average product price by category.

db.products_catalogue.aggregate([
    {
        $match: {
            active: true
        }
    },
    {
        $group: {
            _id: "$category",
            products: {
                $sum: 1
            },
            averagePrice: {
                $avg: "$price.amount"
            }
        }
    },
    {
        $sort: {
            averagePrice: -1
        }
    }
]);