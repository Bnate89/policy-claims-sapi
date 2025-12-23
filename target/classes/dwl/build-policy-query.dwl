%dw 2.0
import * from dw::core::Strings

/**
 * Builds dynamic SQL query for policy search based on query parameters
 */
fun buildPolicyWhereClause(queryParams: Object): String = do {
    var conditions = []
    var withCustomerId = if (!isEmpty(queryParams.customerId)) 
        conditions << "customer_id = :customerId" 
        else conditions
    var withPolicyType = if (!isEmpty(queryParams.policyType)) 
        withCustomerId << "policy_type = :policyType" 
        else withCustomerId
    var withStatus = if (!isEmpty(queryParams.status)) 
        withPolicyType << "status = :status" 
        else withPolicyType
    var withStartDate = if (!isEmpty(queryParams.startDate)) 
        withStatus << "start_date >= :startDate" 
        else withStatus
    var withEndDate = if (!isEmpty(queryParams.endDate)) 
        withStartDate << "end_date <= :endDate" 
        else withStartDate
    ---
    if (sizeOf(withEndDate) > 0)
        " WHERE " ++ (withEndDate joinBy " AND ")
    else
        ""
}

fun buildPolicyInputParameters(queryParams: Object): Object = 
    queryParams filterObject ((value, key) -> value != null and value != "")
