# Wain App — Firestore Database Schema

## Collections

### `users`
```
users/{userId}
├── name_ar: string
├── name_en: string
├── phone: string
├── email: string (optional)
├── avatar_url: string
├── area: string
├── language: string ("ar" | "en")
├── favorites: array<string> (listing IDs)
├── created_at: timestamp
├── updated_at: timestamp
└── kids/ (subcollection)
    └── {kidId}
        ├── name: string
        ├── age: number
        ├── gender: string ("boy" | "girl")
        ├── notes: string
        └── created_at: timestamp
```

### `listings`
```
listings/{listingId}
├── type: string ("nursery" | "summer_club" | "activity" | "babysitter")
├── name_ar: string
├── name_en: string
├── description_ar: string
├── description_en: string
├── area: string ("farwaniya" | "hawalli" | "salmiya" | "sabah_al_salem" | "jahra" | "capital" | "ahmadi" | "mubarak")
├── location_geo: geopoint {lat, lng}
├── address_ar: string
├── address_en: string
├── price_packages: array<{
│     name_ar: string,
│     name_en: string,
│     price: number,
│     duration: string,
│     description_ar: string,
│     description_en: string
│   }>
├── age_min: number
├── age_max: number
├── photos: array<string> (URLs)
├── cover_photo: string (URL)
├── rating_avg: number
├── reviews_count: number
├── facilities: array<string> ("swimming" | "playground" | "ac" | "meals" | "bus" | "parking" | "cctv" | "medical" | "wifi" | "outdoor" | "indoor")
├── transportation: boolean
├── featured: boolean
├── active: boolean
├── availability_dates: array<{start: timestamp, end: timestamp}>
├── schedule: map {
│     sunday: {open: string, close: string},
│     monday: {open: string, close: string},
│     ...
│   }
├── whatsapp: string
├── phone: string
├── instagram: string (optional)
├── website: string (optional)
├── owner_id: string (admin user ID)
├── created_at: timestamp
└── updated_at: timestamp
```

### `bookings`
```
bookings/{bookingId}
├── userId: string
├── listingId: string
├── listing_name_ar: string
├── listing_name_en: string
├── listing_type: string
├── package: map {name_ar, name_en, price, duration}
├── start_date: timestamp
├── end_date: timestamp
├── kids: array<{name, age}>
├── status: string ("pending" | "confirmed" | "completed" | "cancelled" | "rejected")
├── total_price: number
├── coupon_code: string (optional)
├── discount: number
├── payment_method: string ("knet" | "card" | "cash" | "tap")
├── payment_status: string ("pending" | "paid" | "refunded")
├── notes: string
├── created_at: timestamp
└── updated_at: timestamp
```

### `reviews`
```
listings/{listingId}/reviews/{reviewId}
├── userId: string
├── user_name: string
├── rating: number (1-5)
├── comment: string
├── approved: boolean
├── created_at: timestamp
```

### `coupons`
```
coupons/{couponId}
├── code: string
├── discount_type: string ("percentage" | "fixed")
├── discount_value: number
├── min_order: number
├── max_uses: number
├── used_count: number
├── listing_id: string (optional — null = all)
├── active: boolean
├── expires_at: timestamp
├── created_at: timestamp
```

### `notifications`
```
notifications/{notifId}
├── userId: string
├── title_ar: string
├── title_en: string
├── body_ar: string
├── body_en: string
├── type: string ("booking" | "reminder" | "promotion" | "review")
├── data: map {listingId, bookingId, ...}
├── read: boolean
├── created_at: timestamp
```

### `admins`
```
admins/{adminId}
├── name: string
├── email: string
├── role: string ("admin" | "sub_admin" | "owner")
├── listing_ids: array<string> (for owner role)
├── active: boolean
├── created_at: timestamp
```
