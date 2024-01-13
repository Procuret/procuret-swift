# Introduction

Procuret API Swift (PS) allows you to perform Procuret API operations in
Swift code. For example, you might like to look up the prices of Procuret
Instalment Plan products, and present them to customers in your e-commerce
software.

Procuret Swift is the open-source component of the [Procuret iOS app](https://apps.apple.com/au/app/procuret/id1634745293).

## Versioning and public interfaces

PS follows [Semantic Versioning](https://semver.org) conventions. At any time,
the repository may included an undocumented type in the `source` directory.
These types should be considered unavailable and their function is not
guaranteed.

// push to github above this

# Available Types

## `struct ProspectivePayment`

A theoretical payment amount, and the number of months over which that payment
would be made, if an applicant successfully applied for a Procuret Instalment
Plan.

### Properties

- `periods` - // Number (Integer) - The number of months over which payment would be made
- `rawPayment` - // string - The monthly payment amount
-

### Static Methods

#### retrieve

Retrieve a single `ProspectivePayment` for given parameters. To use this
method, you must know a valid `periods` value in advance.

##### Parameters

// @hugh, please note, the spelling error in `principal` vs `principle` -> i assume it doesnt matter...

1. `principal` - `String` - A string-encoded number representing the principal
   value of the prospective loan. For example, a total invoice value. Minimum
   value `500` currency units.
2. `cycle` - `integer` - by default, set to 1, determines whether the payment is in advance or in arrears.

// up to here

3. `supplier` - `String` - Your Supplier ID. Consult your Procuret
   partnership manager if you are unsure of this value.
4. `periods` - `integer` - The integer number of months over which the instalment
   plan would be paid.
5. `endpoint` - `Optional<String>` - Optionally override the API endpoint.
   Useful in testing a demonstration environments.
6. `callback` - `(Error?, ProspectivePayment?)` - A function taking
   optional error and result parameters, in which you can handle the API response.
7. [undocumented, do not use, do not provide a value]
