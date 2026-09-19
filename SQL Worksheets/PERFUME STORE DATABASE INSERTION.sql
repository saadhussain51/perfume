-- INSERTION IN FRAGRANCE CATEGORY TABLE
INSERT INTO FragranceCategory (CategoryID, CategoryName, IntensityLevel, OilConcentration, LastingHours, AllergicReactions, PositiveImpacts, SuitableOccasions) 
VALUES(1, 'Amber', 'Very Strong', '25–30%', '12+ Hours', 'May cause slight skin irritation in sensitive skin types; generally warm and comforting.', 'Long-lasting, Warm', 'Evening Events, Winter Wear');

INSERT INTO FragranceCategory (CategoryID, CategoryName, IntensityLevel, OilConcentration, LastingHours, AllergicReactions, PositiveImpacts, SuitableOccasions)
VALUES(2, 'Spicy', 'High', '15–20%', '7-9 Hours', 'Can be strong for sensitive noses; invigorating for most users.', 'Bold, Energetic', 'Festive Occasions, Night Parties');

INSERT INTO FragranceCategory (CategoryID, CategoryName, IntensityLevel, OilConcentration, LastingHours, AllergicReactions, PositiveImpacts, SuitableOccasions)
VALUES(3, 'Oriental', 'Medium', '12–18%', '6-8 Hours', 'Rare skin reactions; exotic and rich aroma.', 'Exotic, Sensual', 'Romantic Dinners, Special Celebrations');

INSERT INTO FragranceCategory (CategoryID, CategoryName, IntensityLevel, OilConcentration, LastingHours, AllergicReactions, PositiveImpacts, SuitableOccasions)
VALUES(4, 'Musky', 'Medium', '5–15%', '5-7 Hours', 'Rare but can trigger mild allergies; comforting for many.', 'Soft, Intimate', 'Casual Gatherings, Date Nights');

INSERT INTO FragranceCategory (CategoryID, CategoryName, IntensityLevel, OilConcentration, LastingHours, AllergicReactions, PositiveImpacts, SuitableOccasions)
VALUES(5, 'Fruity', 'Light', '5–15%', '4-6 Hours', 'Very low chance of allergic reactions; refreshing.', 'Fresh, Youthful', 'Daily Use, Spring and Summer Outings');

INSERT INTO FragranceCategory (CategoryID, CategoryName, IntensityLevel, OilConcentration, LastingHours, AllergicReactions, PositiveImpacts, SuitableOccasions)
VALUES(6, 'Citrus', 'Light', '2–5%', '3-5 Hours', 'Minimal allergic reactions; very refreshing and clean.', 'Fresh, Energetic', 'Office Wear, Summer Days');

-- INSERTION IN GENDER CATEGORY TABLE
INSERT INTO GenderCategory VALUES(1 , 'Men');
INSERT INTO GenderCategory VALUES(2 , 'Women');

-- INSERTION IN PERFUMES , PERFUME FRAGRANCE MAP , PERFUME GENDERS MAP TABLE
// Perfumes insertion Ambers For Men
INSERT INTO Perfume VALUES(1, 'All Rounder Shoaib Malik', 7999.00, 5000, 'A bold and charismatic amber-based scent representing confidence and endurance.', '../Images/MENS/AMBER/All Rounder Shoaib Malik.webp');

INSERT INTO Perfume VALUES(2, 'Gold Shimmer', 7499.00, 5000, 'An elegant blend of amber warmth and golden allure, perfect for luxury evenings.', '../Images/MENS/AMBER/Gold Shimmer.webp');

INSERT INTO Perfume VALUES(3, 'Janan Oudh Perfume Body Spray', 6899.00, 5000, 'A powerful fusion of Oudh and rich amber notes, creating a deep and captivating masculine aura.', '../Images/MENS/AMBER/Janan Oudh Por Home Perfume Body Spray.webp');

INSERT INTO Perfume VALUES(4, 'Janan Platinum', 7799.00, 5000, 'Refined amber notes mixed with earthy tones for a sophisticated and long-lasting scent.', '../Images/MENS/AMBER/Janan Platinum.webp');

INSERT INTO Perfume VALUES(5, 'Janan Sports', 6699.00, 5000, 'A sporty twist on traditional amber with fresh yet intense aroma, ideal for energetic lifestyles.', '../Images/MENS/AMBER/Janan Sports.webp');

INSERT INTO Perfume VALUES(6, 'Ruler', 7999.00, 5000, 'Commanding and majestic, this amber scent is made for those who lead with presence.', '../Images/MENS/AMBER/Ruler.webp');

INSERT INTO Perfume VALUES(7, 'Ziya Gold Attar', 7299.00, 5000, 'A rich golden attar with dominant amber notes, timeless and spiritual.', '../Images/MENS/AMBER/Ziya Gold Attar.webp');

-- Mapping Perfume to Fragrance (Amber -> Category ID 1)
INSERT INTO PerfumeFragranceMap VALUES(1 , 1);
INSERT INTO PerfumeFragranceMap VALUES(2 , 1);
INSERT INTO PerfumeFragranceMap VALUES(3 , 1);
INSERT INTO PerfumeFragranceMap VALUES(4 , 1);
INSERT INTO PerfumeFragranceMap VALUES(5 , 1);
INSERT INTO PerfumeFragranceMap VALUES(6 , 1);
INSERT INTO PerfumeFragranceMap VALUES(7 , 1);

-- Mapping Perfume to Gender (Amber-> Category ID 1)
INSERT INTO PerfumeGenderMap VALUES(1 , 1);
INSERT INTO PerfumeGenderMap VALUES(2 , 1);
INSERT INTO PerfumeGenderMap VALUES(3 , 1);
INSERT INTO PerfumeGenderMap VALUES(4 , 1);
INSERT INTO PerfumeGenderMap VALUES(5 , 1);
INSERT INTO PerfumeGenderMap VALUES(6 , 1);
INSERT INTO PerfumeGenderMap VALUES(7 , 1);

// insertion of Citrus fragrance category for men
INSERT INTO Perfume VALUES (8, 'Deep Blue', 3199.00, 5000, 'An invigorating citrus scent with oceanic freshness, ideal for daily wear.', '../Images/MENS/CITRUS/Deep Blue.webp');

INSERT INTO Perfume VALUES (9, 'Great Summit', 3499.00, 5000, 'A crisp citrus fragrance inspired by high altitudes and adventure.', '../Images/MENS/CITRUS/Great Summit.webp');

INSERT INTO Perfume VALUES (10, 'Janan Intense', 3799.00, 5000, 'Vibrant citrus with a burst of intensity, designed for bold daytime personalities.', '../Images/MENS/CITRUS/Janan Intense.webp');

INSERT INTO Perfume VALUES (11, 'Janan Oudh', 3399.00, 5000, 'An exotic fusion of Oudh and zesty citrus for a modern twist.', '../Images/MENS/CITRUS/Janan Oudh.webp');

INSERT INTO Perfume VALUES (12, 'Janan Platinum', 3699.00, 5000, 'Elegant citrus layers with subtle spices for a fresh yet refined scent.', '../Images/MENS/CITRUS/Janan Platinum.webp');

INSERT INTO Perfume VALUES (13, 'Janan Sport Gift Set', 3999.00, 5000, 'Sporty and refreshing citrus blend gift set designed for energetic lifestyles.', '../Images/MENS/CITRUS/Janan Sport Gift Set.webp');

INSERT INTO Perfume VALUES (14, 'Rhythm Fire', 2899.00, 5000, 'A lively citrus mix with a warm undertone, built to energize your day.', '../Images/MENS/CITRUS/Rhythm Fire.webp');

INSERT INTO Perfume VALUES (15, 'Untamed Spirit', 3099.00, 5000, 'Wild citrus notes burst with freshness, tailored for the free-spirited.', '../Images/MENS/CITRUS/Untamed Spirit.webp');

INSERT INTO Perfume VALUES (16, 'Vocal Premium', 3599.00, 5000, 'A premium citrus scent with a clean and crisp vibe for classy individuals.', '../Images/MENS/CITRUS/Vocal Premium.webp');

INSERT INTO Perfume VALUES (17, 'Zarar For Men Gold Edition', 3899.00, 5000, 'Gold-class citrus composition with lasting freshness and sophistication.', '../Images/MENS/CITRUS/zara or Men Gold Edition.jpg');

INSERT INTO Perfume VALUES (18, 'Zarar Men Blue', 3199.00, 5000, 'Cool and fresh citrus tones perfect for summer mornings and office wear.', '../Images/MENS/CITRUS/Zarar Men Blue.webp');

-- Mapping Perfume to Fragrance (Citrus -> Category ID 6)
INSERT INTO PerfumeFragranceMap VALUES (8, 6);
INSERT INTO PerfumeFragranceMap VALUES (9, 6);
INSERT INTO PerfumeFragranceMap VALUES (10, 6);
INSERT INTO PerfumeFragranceMap VALUES (11, 6);
INSERT INTO PerfumeFragranceMap VALUES (12, 6);
INSERT INTO PerfumeFragranceMap VALUES (13, 6);
INSERT INTO PerfumeFragranceMap VALUES (14, 6);
INSERT INTO PerfumeFragranceMap VALUES (15, 6);
INSERT INTO PerfumeFragranceMap VALUES (16, 6);
INSERT INTO PerfumeFragranceMap VALUES (17, 6);
INSERT INTO PerfumeFragranceMap VALUES (18, 6);

-- Mapping Perfume to Gender (Mens -> Gender ID 1)
INSERT INTO PerfumeGenderMap VALUES (8, 1);
INSERT INTO PerfumeGenderMap VALUES (9, 1);
INSERT INTO PerfumeGenderMap VALUES (10, 1);
INSERT INTO PerfumeGenderMap VALUES (11, 1);
INSERT INTO PerfumeGenderMap VALUES (12, 1);
INSERT INTO PerfumeGenderMap VALUES (13, 1);
INSERT INTO PerfumeGenderMap VALUES (14, 1);
INSERT INTO PerfumeGenderMap VALUES (15, 1);
INSERT INTO PerfumeGenderMap VALUES (16, 1);
INSERT INTO PerfumeGenderMap VALUES (17, 1);
INSERT INTO PerfumeGenderMap VALUES (18, 1);

// Insertion of Fruity For Men

INSERT INTO Perfume VALUES (19, 'Intenso', 4500.00, 5000, 'A dynamic fruity fragrance offering a perfect balance of freshness and masculinity.', '../Images/MENS/FRUITY/Intenso.webp');
INSERT INTO Perfume VALUES (20, 'Janan Oudh Body Spray Brown', 3200.00, 5000, 'An exotic fruity scent with hints of oud for a powerful yet refreshing aroma.', '../Images/MENS/FRUITY/Janan Oudh Body Spray Brown.webp');
INSERT INTO Perfume VALUES (21, 'Legacy', 4700.00, 5000, 'A signature fruity fragrance representing timeless elegance and freshness.', '../Images/MENS/FRUITY/Legacy.webp');
INSERT INTO Perfume VALUES (22, 'Mika', 4000.00, 5000, 'Fresh fruity notes combined with a youthful, energetic vibe.', '../Images/MENS/FRUITY/Mika.webp');
INSERT INTO Perfume VALUES (23, 'Wasim Akram', 5100.00, 5000, 'A classic fruity fragrance endorsed by the legend himself, energetic and refreshing.', '../Images/MENS/FRUITY/Wasim Akram.webp');

-- Map Perfume to Fragrance Category (Fruity)
INSERT INTO PerfumeFragranceMap VALUES (19, 5);
INSERT INTO PerfumeFragranceMap VALUES (20, 5);
INSERT INTO PerfumeFragranceMap VALUES (21, 5);
INSERT INTO PerfumeFragranceMap VALUES (22, 5);
INSERT INTO PerfumeFragranceMap VALUES (23, 5);
INSERT INTO PerfumeFragranceMap VALUES (17, 5);

-- Map Perfume to Gender (Men)
INSERT INTO PerfumeGenderMap VALUES (19, 1);
INSERT INTO PerfumeGenderMap VALUES (20, 1);
INSERT INTO PerfumeGenderMap VALUES (21, 1);
INSERT INTO PerfumeGenderMap VALUES (22, 1);
INSERT INTO PerfumeGenderMap VALUES (23, 1);

-- Insert New Perfumes Musky for men
INSERT INTO Perfume VALUES (25, 'Black Musk', 4200.00, 5000, 'An intense musky fragrance delivering warmth and deep sensuality.', '../Images/MENS/MUSKY/Black Musk.webp');
INSERT INTO Perfume VALUES (26, 'Janan Intense Gold Edition', 5200.00, 5000, 'Rich musky notes blended with luxurious golden undertones.', '../Images/MENS/MUSKY/Janan Intense Gold Edition.webp');
INSERT INTO Perfume VALUES (27, 'White Musk', 4000.00, 5000, 'A soft, clean musk fragrance perfect for daily elegance.', '../Images/MENS/MUSKY/White Musk.webp');
INSERT INTO Perfume VALUES (28, 'Ziya Platinum Attar', 3700.00, 5000, 'A pure musky attar crafted for a modern yet traditional feel.', '../Images/MENS/MUSKY/Ziya Platinum Attar.webp');
INSERT INTO Perfume VALUES (29, 'Ziya Silver Attar', 3500.00, 5000, 'An elegant silver-toned musk attar with smooth finishing.', '../Images/MENS/MUSKY/Ziya Silver Attar.webp');

-- Map to Musky Fragrance Category
INSERT INTO PerfumeFragranceMap VALUES (25, 4); -- Black Musk
INSERT INTO PerfumeFragranceMap VALUES (26, 4); -- Janan Intense Gold Edition
INSERT INTO PerfumeFragranceMap VALUES (5, 4); -- Janan Sports (already added previously)
INSERT INTO PerfumeFragranceMap VALUES (27, 4); -- White Musk
INSERT INTO PerfumeFragranceMap VALUES (7, 4);  -- Ziya Gold Attar (already added previously)
INSERT INTO PerfumeFragranceMap VALUES (28, 4); -- Ziya Platinum Attar
INSERT INTO PerfumeFragranceMap VALUES (29, 4); -- Ziya Silver Attar

-- Map New Perfumes to Men Gender
INSERT INTO PerfumeGenderMap VALUES (25, 1);
INSERT INTO PerfumeGenderMap VALUES (26, 1);
INSERT INTO PerfumeGenderMap VALUES (27, 1);
INSERT INTO PerfumeGenderMap VALUES (28, 1);
INSERT INTO PerfumeGenderMap VALUES (29, 1);

-- Insert New Oriental Perfumes or men
INSERT INTO Perfume VALUES (30, 'Jahangir Khan 555', 5500.00, 5000, 'An oriental fragrance with a legacy of strength, passion, and excellence.', '../Images/MENS/ORIENTAL/Jahangir Khan 555.webp');
INSERT INTO Perfume VALUES (31, 'Janan Pour Homme Gold Edition', 5800.00, 5000, 'Elegant oriental blend capturing timeless sophistication and warmth.', '../Images/MENS/ORIENTAL/Janan Pour Homme Gold Edition.webp');
INSERT INTO Perfume VALUES (32, 'Oudh Al Junaid', 6200.00, 5000, 'A rich oriental oudh, combining heritage with luxurious depth.', '../Images/MENS/ORIENTAL/Oudh Al Junaid.webp');
INSERT INTO Perfume VALUES (33, 'Stallion', 5100.00, 5000, 'Powerful oriental fragrance symbolizing strength and charisma.', '../Images/MENS/ORIENTAL/Stallion.webp');
INSERT INTO Perfume VALUES (34, 'Zarar Blue', 4900.00, 5000, 'Refreshing yet exotic oriental scent with vibrant energy.', '../Images/MENS/ORIENTAL/Zarar Blue.webp');
INSERT INTO Perfume VALUES (35, 'Zarar For Men White', 4700.00, 5000, 'A lighter oriental aroma crafted for daily luxury and elegance.', '../Images/MENS/ORIENTAL/Zarar For Men White.webp');

-- Map to Oriental Fragrance Category
INSERT INTO PerfumeFragranceMap VALUES (30, 3); -- Jahangir Khan 555
INSERT INTO PerfumeFragranceMap VALUES (31, 3); -- Janan Pour Homme Gold Edition
INSERT INTO PerfumeFragranceMap VALUES (32, 3); -- Oudh Al Junaid
INSERT INTO PerfumeFragranceMap VALUES (33, 3); -- Stallion
INSERT INTO PerfumeFragranceMap VALUES (34, 3); -- Zarar Blue
INSERT INTO PerfumeFragranceMap VALUES (35, 3); -- Zarar For Men White

-- Map to Men Gender
INSERT INTO PerfumeGenderMap VALUES (30, 1);
INSERT INTO PerfumeGenderMap VALUES (31, 1);
INSERT INTO PerfumeGenderMap VALUES (32, 1);
INSERT INTO PerfumeGenderMap VALUES (33, 1);
INSERT INTO PerfumeGenderMap VALUES (34, 1);
INSERT INTO PerfumeGenderMap VALUES (35, 1);

-- Insert New Spicy Perfumes
INSERT INTO Perfume VALUES (36, 'Classic By Adnan Siddique', 5300.00, 5000, 'A bold spicy fragrance reflecting elegance and charisma.', '../Images/MENS/SPICY/Classic Pour Homme Adnan Siddique.webp');
INSERT INTO Perfume VALUES (37, 'Deep Black', 5600.00, 5000, 'Intense spicy notes blended with timeless masculinity.', '../Images/MENS/SPICY/Deep Black.webp');
INSERT INTO Perfume VALUES (38, 'Edge', 5000.00, 5000, 'Energetic and spicy, perfect for bold personalities.', '../Images/MENS/SPICY/Edge.webp');
INSERT INTO Perfume VALUES (40, 'Mika Noir', 5200.00, 5000, 'Dark spicy blend evoking mystery and sophistication.', '../Images/MENS/SPICY/Mika Noir.webp');
INSERT INTO Perfume VALUES (41, 'Pour Homme 3', 5100.00, 5000, 'Fresh spicy burst for the modern gentleman.', '../Images/MENS/SPICY/Pour Homme 3.webp');

-- Map new perfumes to Spicy
INSERT INTO PerfumeFragranceMap VALUES (36, 2); -- Classic Pour Homme Adnan Siddique
INSERT INTO PerfumeFragranceMap VALUES (37, 2); -- Deep Black
INSERT INTO PerfumeFragranceMap VALUES (38, 2); -- Edge
INSERT INTO PerfumeFragranceMap VALUES (39, 2); -- Jahangir Khan
INSERT INTO PerfumeFragranceMap VALUES (40, 2); -- Mika Noir
INSERT INTO PerfumeFragranceMap VALUES (41, 2); -- Pour Homme 3

-- Map already existing perfumes to Spicy
INSERT INTO PerfumeFragranceMap VALUES (11, 2); -- Janan Oudh (ID 17 previously inserted)
INSERT INTO PerfumeFragranceMap VALUES (6, 2);  -- Ruler (ID 6 previously inserted)
INSERT INTO PerfumeFragranceMap VALUES (30, 2); -- Jahangir Khan
-- Map new perfumes to Men Gender
INSERT INTO PerfumeGenderMap VALUES (36, 1);
INSERT INTO PerfumeGenderMap VALUES (37, 1);
INSERT INTO PerfumeGenderMap VALUES (38, 1);
INSERT INTO PerfumeGenderMap VALUES (40, 1);
INSERT INTO PerfumeGenderMap VALUES (41, 1);

-- Insert New Women's Amber Perfumes
INSERT INTO Perfume VALUES (42, 'Floral Affair', 5800.00, 5000, 'A luxurious amber scent blended with delicate floral notes.', '../Images/WOMEN/AMBER/Floral Affair.webp');
INSERT INTO Perfume VALUES (43, 'Lilane Pour Femme', 6000.00, 5000, 'An elegant composition of amber warmth and feminine charm.', '../Images/WOMEN/AMBER/Lilane Pour Femme.webp');
INSERT INTO Perfume VALUES (44, 'Pour FEMME - 1', 5500.00, 5000, 'Rich amber base with subtle sophisticated accords.', '../Images/WOMEN/AMBER/Pour FEMME - 1.webp');
INSERT INTO Perfume VALUES (45, 'Pour FEMME - 2', 5600.00, 5000, 'A captivating blend of sensual amber and soft florals.', '../Images/WOMEN/AMBER/Pour FEMME - 2.webp');
INSERT INTO Perfume VALUES (46, 'Pour FEMME - 3', 5400.00, 5000, 'Warm amber essence intertwined with feminine elegance.', '../Images/WOMEN/AMBER/Pour FEMME - 3.webp');
INSERT INTO Perfume VALUES (47, 'Pour FEMME - 4', 5700.00, 5000, 'Enchanting amber notes perfect for everyday glamour.', '../Images/WOMEN/AMBER/Pour FEMME - 4.webp');

-- Map perfumes to Amber fragrance
INSERT INTO PerfumeFragranceMap VALUES (42, 1);
INSERT INTO PerfumeFragranceMap VALUES (43, 1);
INSERT INTO PerfumeFragranceMap VALUES (44, 1);
INSERT INTO PerfumeFragranceMap VALUES (45, 1);
INSERT INTO PerfumeFragranceMap VALUES (46, 1);
INSERT INTO PerfumeFragranceMap VALUES (47, 1);

-- Map perfumes to Women gender
INSERT INTO PerfumeGenderMap VALUES (42, 2);
INSERT INTO PerfumeGenderMap VALUES (43, 2);
INSERT INTO PerfumeGenderMap VALUES (44, 2);
INSERT INTO PerfumeGenderMap VALUES (45, 2);
INSERT INTO PerfumeGenderMap VALUES (46, 2);
INSERT INTO PerfumeGenderMap VALUES (47, 2);

-- Insert New Women's Citrus Perfumes
INSERT INTO Perfume VALUES (48, 'Beautiful By Schaniera Akram', 5200.00, 5000, 'A refreshing citrus burst with an elegant feminine touch.', '../Images/WOMEN/CITRUS/Beautiful By Schaniera Akram.webp');
INSERT INTO Perfume VALUES (49, 'Pour Homme 1 Blue', 5000.00, 5000, 'A zesty and vibrant citrus scent perfect for dynamic women.', '../Images/WOMEN/CITRUS/Pour Homme 1 Blue.webp');
INSERT INTO Perfume VALUES (50, 'Pour Homme 4 Pink', 5100.00, 5000, 'Citrusy freshness blended with soft floral hints.', '../Images/WOMEN/CITRUS/Pour Homme 4 Pink.webp');

-- Map perfumes to Citrus fragrance
INSERT INTO PerfumeFragranceMap VALUES (48, 6);
INSERT INTO PerfumeFragranceMap VALUES (49, 6);
INSERT INTO PerfumeFragranceMap VALUES (50, 6);

-- Map perfumes to Women gender
INSERT INTO PerfumeGenderMap VALUES (48, 2);
INSERT INTO PerfumeGenderMap VALUES (49, 2);
INSERT INTO PerfumeGenderMap VALUES (50, 2);

-- Insert New Women's Fruity Perfumes
INSERT INTO Perfume VALUES (51, 'AAPA''s Blossom', 4800.00, 5000, 'A fruity fragrance with a delicate floral undertone for an uplifting mood.', '../Images/WOMEN/FRUITY/AAPA''s Blossom.webp');
INSERT INTO Perfume VALUES (52, 'An Evening to Remember', 4900.00, 5000, 'A fresh fruity blend that makes every moment unforgettable.', '../Images/WOMEN/FRUITY/An Evening to Remember.webp');
INSERT INTO Perfume VALUES (53, 'J. Pour Femme Pink', 5000.00, 5000, 'A sweet fruity fragrance with a playful and joyful appeal.', '../Images/WOMEN/FRUITY/J. Pour Femme Pink.webp');
INSERT INTO Perfume VALUES (54, 'Legacy For Women', 5100.00, 5000, 'A luxurious fruity perfume for a sophisticated woman.', '../Images/WOMEN/FRUITY/Legacy.webp');
INSERT INTO Perfume VALUES (55, 'Marjan', 4700.00, 5000, 'A zesty and refreshing fruity fragrance perfect for the warm season.', '../Images/WOMEN/FRUITY/Marjan.webp');
INSERT INTO Perfume VALUES (56, 'Wasim Akram 50 For Her', 5200.00, 5000, 'A timeless fruity fragrance crafted for a confident woman.', '../Images/WOMEN/FRUITY/Wasim Akram 50 For Her.webp');

-- Map perfumes to Fruity fragrance
INSERT INTO PerfumeFragranceMap VALUES (51, 5);
INSERT INTO PerfumeFragranceMap VALUES (52, 5);
INSERT INTO PerfumeFragranceMap VALUES (53, 5);
INSERT INTO PerfumeFragranceMap VALUES (54, 5);
INSERT INTO PerfumeFragranceMap VALUES (55, 5);
INSERT INTO PerfumeFragranceMap VALUES (56, 5);

-- Map perfumes to Women gender
INSERT INTO PerfumeGenderMap VALUES (51, 2);
INSERT INTO PerfumeGenderMap VALUES (52, 2);
INSERT INTO PerfumeGenderMap VALUES (53, 2);
INSERT INTO PerfumeGenderMap VALUES (54, 2);
INSERT INTO PerfumeGenderMap VALUES (55, 2);
INSERT INTO PerfumeGenderMap VALUES (56, 2);

-- Insert New Women's Musky Perfumes
INSERT INTO Perfume VALUES (57, 'Bella Pour Femme', 5500.00, 5000, 'A smooth musky fragrance for women with a touch of elegance and mystery.', '../Images/WOMEN/MUSKY/Bella Pour Femme.webp');
INSERT INTO Perfume VALUES (58, 'Janan Pour Femme', 5600.00, 5000, 'A sophisticated musky fragrance with a blend of floral notes for a timeless appeal.', '../Images/WOMEN/MUSKY/Janan Pour Femme.webp');
INSERT INTO Perfume VALUES (59, 'Pour FEMME 5 Yellow', 5700.00, 5000, 'A fresh musky scent that brings warmth and radiance to any occasion.', '../Images/WOMEN/MUSKY/Pour FEMME 5 Yellow.webp');

-- Map perfumes to Musky fragrance
INSERT INTO PerfumeFragranceMap VALUES (57, 4);
INSERT INTO PerfumeFragranceMap VALUES (58, 4);
INSERT INTO PerfumeFragranceMap VALUES (59, 4);

-- Map perfumes to Women gender
INSERT INTO PerfumeGenderMap VALUES (57, 2);
INSERT INTO PerfumeGenderMap VALUES (58, 2);
INSERT INTO PerfumeGenderMap VALUES (59, 2);

-- Insert New Women's Oriental Perfumes
INSERT INTO Perfume VALUES (60, 'AAPAs Aroma', 5900.00, 5000, 'An exotic oriental fragrance that captures the essence of the East, with rich floral and spicy notes.' , '../Images/WOMEN/ORIENTAL/AAPAs Aroma.webp');
INSERT INTO Perfume VALUES (61, 'Prestrige', 6000.00, 5000, 'A sophisticated oriental perfume with an intriguing mix of spice and floral, perfect for any occasion.', '../Images/WOMEN/ORIENTAL/Prestrige.webp');

-- Map perfumes to Oriental fragrance
INSERT INTO PerfumeFragranceMap VALUES (60, 3);
INSERT INTO PerfumeFragranceMap VALUES (61, 3);

-- Map perfumes to Women gender
INSERT INTO PerfumeGenderMap VALUES (60, 2);
INSERT INTO PerfumeGenderMap VALUES (61, 2);

-- Insert New Women's Spicy Perfumes
INSERT INTO Perfume VALUES (62, 'Blossom Pour Femme', 6100.00, 5000, 'A spicy fragrance with a refreshing floral twist, perfect for the dynamic woman.', '../Images/WOMEN/SPICY/Blossom Pour Femme.webp');
INSERT INTO Perfume VALUES (65, 'Prestrige 2', 6400.00, 5000, 'A spicy perfume with an exotic touch, combining warmth and depth for a lasting impression.', '../Images/WOMEN/SPICY/Prestrige 2.webp');

-- Map perfumes to Spicy fragrance
INSERT INTO PerfumeFragranceMap VALUES (62, 2);
INSERT INTO PerfumeFragranceMap VALUES (54, 2);
INSERT INTO PerfumeFragranceMap VALUES (55, 2);
INSERT INTO PerfumeFragranceMap VALUES (65, 2);
INSERT INTO PerfumeFragranceMap VALUES (58, 2);

-- Map perfumes to Women gender
INSERT INTO PerfumeGenderMap VALUES (62, 2);
INSERT INTO PerfumeGenderMap VALUES (65, 2);


-- INSERTION IN PACKAGING TYPE , FEATURES AND PACKAGING FEATURE MAP TABLES
INSERT INTO PackagingType VALUES (1, 'Classic Packaging', 0);
INSERT INTO PackagingType VALUES (2, 'Gift Packaging', 500);
INSERT INTO PackagingType VALUES (3, 'Signature Luxury Packaging', 1500);

-- Shared Feature
INSERT INTO Feature VALUES (1, 'Brand Bag');

-- Classic Packaging Features
INSERT INTO Feature VALUES (2, 'Standard Wrapping');
INSERT INTO Feature VALUES (3, 'Thank You Note Card');
INSERT INTO Feature VALUES (4, 'Basic Protection');

-- Gift Packaging Features
INSERT INTO Feature VALUES (5, 'Gift Box');
INSERT INTO Feature VALUES (6, 'Gift Ribbon');
INSERT INTO Feature VALUES (7, 'Personalized Gift Card');
INSERT INTO Feature VALUES (8, 'Premium Wrapping Paper');
INSERT INTO Feature VALUES (9, 'Decorative Gift Bag');
INSERT INTO Feature VALUES (10, 'Additional Perfume Tester');

-- Luxury Packaging Features
INSERT INTO Feature VALUES (11, 'Wooden Luxury Box');
INSERT INTO Feature VALUES (12, 'Golden Wax Seal');
INSERT INTO Feature VALUES (13, 'Custom Engraving');
INSERT INTO Feature VALUES (14, 'Embossed Logo');
INSERT INTO Feature VALUES (15, 'Premium Velvet Lining');
INSERT INTO Feature VALUES (16, 'Luxury Satin Ribbon');
INSERT INTO Feature VALUES (17, 'Signature Closure');

-- Classic Packaging (ID 1)
INSERT INTO PackagingFeatureMap VALUES (1, 2);
INSERT INTO PackagingFeatureMap VALUES (1, 3);
INSERT INTO PackagingFeatureMap VALUES (1, 4);
INSERT INTO PackagingFeatureMap VALUES (1, 1); -- Brand Bag

-- Gift Packaging (ID 2)
INSERT INTO PackagingFeatureMap VALUES (2, 5);
INSERT INTO PackagingFeatureMap VALUES (2, 6);
INSERT INTO PackagingFeatureMap VALUES (2, 7);
INSERT INTO PackagingFeatureMap VALUES (2, 8);
INSERT INTO PackagingFeatureMap VALUES (2, 9);
INSERT INTO PackagingFeatureMap VALUES (2, 10);
INSERT INTO PackagingFeatureMap VALUES (2, 1); -- Brand Bag

-- Signature Luxury Packaging (ID 3)
INSERT INTO PackagingFeatureMap VALUES (3, 11);
INSERT INTO PackagingFeatureMap VALUES (3, 12);
INSERT INTO PackagingFeatureMap VALUES (3, 13);
INSERT INTO PackagingFeatureMap VALUES (3, 14);
INSERT INTO PackagingFeatureMap VALUES (3, 15);
INSERT INTO PackagingFeatureMap VALUES (3, 16);
INSERT INTO PackagingFeatureMap VALUES (3, 17);
INSERT INTO PackagingFeatureMap VALUES (3, 10);
INSERT INTO PackagingFeatureMap VALUES (3, 1); -- Brand Bag

-- INSERTION IN PERFUME STORE USERS TABLE ( CUSTOMERS AND MANAGERS )
INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType, AccountCreationDate)
VALUES (1, 'Muhammad', 'Sajid', 'muhammadsajid123dd', '03190547353', 'MSajid@143', 'Manager', SYSDATE);

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType, AccountCreationDate)
VALUES (2, 'Zubair', 'Ghaffar', 'zubairghaffar@gmail.com', '03007654321', 'Zubair@143', 'Manager', SYSDATE);

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType, AccountCreationDate)
VALUES (3, 'Fahad', 'Khan', 'fahadkhan@gmail.com', '03111222333', 'Fahad@123', 'Manager', SYSDATE);

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType, AccountCreationDate)
VALUES (4, 'Saim', 'Abbasi', 'saimabbasi@gmail.com', '03445556677', 'Saim@123', 'Manager', SYSDATE);

INSERT INTO PerfumeStoreManagers (ManagerID, CNIC, ManagerRole)
VALUES (1, '37405-9248737-7',  'Inventory Manager');

INSERT INTO PerfumeStoreManagers (ManagerID, CNIC, ManagerRole)
VALUES (2, '35201-7654321-2', 'Product Manager');

INSERT INTO PerfumeStoreManagers (ManagerID, CNIC, ManagerRole)
VALUES (3, '35103-1122334-3', 'Order Manager');

INSERT INTO PerfumeStoreManagers (ManagerID, CNIC, ManagerRole)
VALUES (4, '35401-4455667-4', 'Sales Manager');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (5, 'Ali', 'Raza', 'ali.raza@example.com', '03001234567', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (6, 'Fatima', 'Khan', 'fatima.khan@example.com', '03019876543', 'secure456', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (7, 'Usman', 'Malik', 'usman.malik@example.com', '03121234567', 'usman321', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (8, 'Hira', 'Shahid', 'hira.shahid@example.com', '03211234567', 'hira321', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (9, 'Ahmed', 'Iqbal', 'ahmed.iqbal@example.com', '03331234567', 'ahmed123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (10, 'Ayesha', 'Javed', 'ayesha.javed@example.com', '03004561234', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (11, 'Bilal', 'Ahmed', 'bilal.ahmed@example.com', '03014569876', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (12, 'Nida', 'Zafar', 'nida.zafar@example.com', '03214569876', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (13, 'Zain', 'Ali', 'zain.ali@example.com', '03134567890', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (14, 'Rabia', 'Saeed', 'rabia.saeed@example.com', '03451234567', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (15, 'Hamza', 'Yousuf', 'hamza.yousuf@example.com', '03001239876', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (16, 'Mehwish', 'Aslam', 'mehwish.aslam@example.com', '03334561234', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (17, 'Tariq', 'Shah', 'tariq.shah@example.com', '03211239876', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (18, 'Sana', 'Mir', 'sana.mir@example.com', '03456782345', 'pass123', 'Customer');

INSERT INTO PerfumeStoreUsers (UserID, FirstName, LastName, Email, Phone, Password, UserType)
VALUES (19, 'Rehan', 'Qureshi', 'rehan.qureshi@example.com', '03111112222', 'pass123', 'Customer');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (5, 10, 'Model Town', 'Lahore', 'Punjab');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (6, 22, 'North Nazimabad', 'Karachi', 'Sindh');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (7, 7, 'Gulbahar', 'Peshawar', 'Khyber Pakhtunkhwa');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (8, 12, 'G-11', 'Islamabad', 'Capital Territory');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (9, 18, 'Satellite Town', 'Quetta', 'Balochistan');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (10, 5, 'Johar Town', 'Lahore', 'Punjab');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (11, 9, 'Wapda Town', 'Multan', 'Punjab');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (12, 15, 'Defence', 'Faisalabad', 'Punjab');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (13, 2, 'PECHS', 'Karachi', 'Sindh');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (14, 8, 'Gulistan-e-Johar', 'Hyderabad', 'Sindh');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (15, 6, 'Cantt Area', 'Sukkur', 'Sindh');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (16, 14, 'University Town', 'Peshawar', 'Khyber Pakhtunkhwa');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (17, 3, 'Mingora Bazar', 'Swat', 'Khyber Pakhtunkhwa');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (18, 11, 'Quetta Cantt', 'Quetta', 'Balochistan');

INSERT INTO PerfumeStoreCustomers (CustomerID, StreetNo, Mohalla, City, Province)
VALUES (19, 7, 'Saryab Road', 'Quetta', 'Balochistan');

-- INSERTION IN PERFUMES INVENTORY BY MANAGER ID 1 ONLY
INSERT INTO PERFUMEINVENTORY (
     PerfumeID, ManagerID, ChangesLog, QuantityChanged, Remarks
) VALUES (
     10, 1, 'Damaged/Expired',
    150, '150 ml stock damaged'
);

SELECT * FROM PERFUMEINVENTORY;
/
-- INSERTION IN PERFUMES ORDERS TABLE AND ORDERLINE
BEGIN
    PlacePerfumeOrder(
        p_OrderID         => 117,
        p_CustomerEmail   => 'muhammad.sajid@example.com',
        p_PackagingTypeID => 2,
        p_PerfumeID       => 21,
        p_OrderedQuantity => 1
    );
END;
/

UPDATE PERFUME
SET PERFUMEIMAGE = '..\Images\WOMEN\SPICY\Prestige 2.webp'
WHERE PERFUMEID = 65;


