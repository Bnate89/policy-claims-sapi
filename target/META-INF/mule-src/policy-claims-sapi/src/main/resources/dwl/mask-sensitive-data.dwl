%dw 2.0

/**
 * Masks sensitive data in policy and claim objects for logging
 */
fun maskCustomerId(customerId: String | Null): String = 
    if (customerId != null and sizeOf(customerId) > 4)
        "***" ++ customerId[-4 to -1]
    else
        "***"

fun maskAmount(amount: Number | Null): String = 
    "***"

fun maskPolicy(policy: Object): Object = 
    policy mapObject (value, key) -> {
        (key): if (key as String == "customerId") maskCustomerId(value as String)
               else if (key as String == "premiumAmount") "***"
               else value
    }

fun maskClaim(claim: Object): Object = 
    claim mapObject (value, key) -> {
        (key): if (key as String == "claimAmount") "***"
               else value
    }
