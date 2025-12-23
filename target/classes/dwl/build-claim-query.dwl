%dw 2.0
import * from dw::core::Strings

/**
 * Builds dynamic SQL query for claim search based on query parameters
 */
fun buildClaimWhereClause(queryParams: Object): String = do {
    var conditions = []
    var withPolicyId = if (!isEmpty(queryParams.policyId)) 
        conditions << "policy_id = :policyId" 
        else conditions
    var withClaimType = if (!isEmpty(queryParams.claimType)) 
        withPolicyId << "claim_type = :claimType" 
        else withPolicyId
    var withStatus = if (!isEmpty(queryParams.status)) 
        withClaimType << "status = :status" 
        else withClaimType
    var withStartDate = if (!isEmpty(queryParams.startDate)) 
        withStatus << "incident_date >= :startDate" 
        else withStatus
    var withEndDate = if (!isEmpty(queryParams.endDate)) 
        withStartDate << "incident_date <= :endDate" 
        else withStartDate
    ---
    if (sizeOf(withEndDate) > 0)
        " WHERE " ++ (withEndDate joinBy " AND ")
    else
        ""
}

fun buildClaimInputParameters(queryParams: Object): Object = 
    queryParams filterObject ((value, key) -> value != null and value != "")
