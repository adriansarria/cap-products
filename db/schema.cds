namespace com.logali;

type Name : String(50);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
}

// type EmailsAddresses_01 : array of {
//     kind  : String;
//     email : String;
// };

// type EmailsAddresses_02 {
//     kind  : String;
//     email : String;
// };

// entity Emails {
//     email_01 :      EmailsAddresses_01;
//     email_02 : many EmailsAddresses_02;
//     email_03 : many {
//         kind  : String;
//         email : String;
//     };
// };

// type Gender : String enum {
//     male;
//     female;
// };

// entity Order {
//     clientGender : Gender;
//     status: Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped = 3;
//         cancel = -1;
//     };
//     priority: String @assert.range enum {
//         high;
//         medium;
//         low;
//     };
// };

// entity Car {
//     key ID : UUID;
//     name : String;
//     virtual discount_1 : Decimal;
//     @Core.Computed : false
//     virtual discount_2 : Decimal;
// };

type Dec  : Decimal(16, 2);

entity Products {
    key ID               : UUID;
        Name             : String not null;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
};

entity Suppliers {
    key ID      : UUID;
        Name    : type of Products : Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
};

entity Categories {
    key ID   : String(1);
        Name : String;
};

entity StockAvailability {
    key ID          : Integer;
        Description : String;
};

entity Currencies {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMeasures {
    key ID          : String(2);
        Description : String;
};

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
};

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
};

entity ProductReview {
    key Name    : String;
        Rating  : Integer;
        Comment : String;
};

entity SalesData {
    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);
};

entity SelProducts                       as select from Products;

entity SelProducts1                      as
    select from Products {
        *
    };

entity SelProducts2                      as
    select from Products {
        Name,
        Price,
        Quantity
    };

entity SelProducts3                      as
    select from Products
    left join ProductReview
        on Products.Name = ProductReview.Name
    {
        Rating,
        Products.Name,
        Sum(Price) as TotalPrice
    }
    group by
        Rating,
        Products.Name
    order by
        Rating;

entity ProjProducts                      as projection on Products;

entity ProjProducts2                     as projection on Products {
    *
};

entity ProjProducts3                     as projection on Products {
    ReleaseDate,
    Name
};

// entity ParamProducts(pName : String)     as
//     select from Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = :pName;

// entity ProjParamProducts(pName : String) as projection on Products where Name = : pName;

extend Products with {
    PriceCondition: String(2);
    PriceDetermination: String(3);
};