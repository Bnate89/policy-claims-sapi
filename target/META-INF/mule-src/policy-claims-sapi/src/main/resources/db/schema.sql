-- FAST Insurance Policy & Claims Database Schema

-- Policies Table
CREATE TABLE policies (
  policy_id VARCHAR(20) PRIMARY KEY,
  customer_id VARCHAR(20) NOT NULL,
  policy_type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  premium_amount DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Claims Table
CREATE TABLE claims (
  claim_id VARCHAR(20) PRIMARY KEY,
  policy_id VARCHAR(20) NOT NULL,
  claim_type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  incident_date DATE NOT NULL,
  claim_amount DECIMAL(10,2) NOT NULL,
  description TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

-- Indexes for Performance
CREATE INDEX idx_policies_customer ON policies(customer_id);
CREATE INDEX idx_policies_status ON policies(status);
CREATE INDEX idx_claims_policy ON claims(policy_id);
CREATE INDEX idx_claims_status ON claims(status);
