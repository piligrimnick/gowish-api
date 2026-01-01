# Authentication Testing Strategy

## Overview
The authentication functionality is tested using **rswag request specs** rather than service objects or controller specs.

## Why This Approach?

### ✅ Benefits of rswag specs for auth:
1. **Documents the OAuth API** - Generates OpenAPI/Swagger documentation automatically
2. **Tests the full integration** - Tests the entire request/response cycle 
3. **Minimal custom logic** - The controller just wraps UserStruct and merges responses
4. **Inherits from Doorkeeper** - Most logic is in `Doorkeeper::TokensController`
5. **Consistent with project** - You're already using rswag for API documentation

### ❌ Why not service objects?
- The custom logic is minimal (3 lines: find user, wrap in UserStruct, merge)
- Would add unnecessary abstraction layer
- Doorkeeper already handles the heavy lifting

### ❌ Why not controller specs?
- Request specs test the same thing with better integration coverage
- rswag adds API documentation as a bonus
- Controller specs are more useful for complex controller logic

## What's Tested

### ✅ Password Grant Flow (`spec/requests/api/v1/auth_spec.rb`)
- **Successful authentication** - Returns access token and user data
- **Invalid password** - Returns 400 with error
- **Missing parameters** - Returns 400 with error
- **User not found** - Returns 400 with error  
- **Security check** - Ensures email is NOT returned in response

### ⏸️ Telegram Grant Flow (Pending)
- Spec structure is ready but marked as pending
- Requires proper Telegram::Auth service mocking
- Can be implemented when you're ready to test Telegram auth

## Running Tests

```bash
# Run auth specs
bundle exec rspec spec/requests/api/v1/auth_spec.rb

# Generate Swagger documentation
bundle exec rake rswag:specs:swaggerize

# Run all specs
bundle exec rspec
```

## Test Results

All password authentication specs pass:
- ✅ 200 response with valid credentials
- ✅ 400 response with invalid credentials  
- ✅ 400 response with missing parameters
- ✅ 400 response when user not found
- ⏸️ Telegram auth (pending implementation)

## Swagger Documentation

The specs automatically generate OpenAPI documentation at:
- `swagger/v1/swagger.yaml`

You can view this in Swagger UI or import into tools like Postman.

## Coverage

Current line coverage: **83.85%** (431 / 514 lines)

## Future Improvements

1. **Add unit tests for UserStruct** if the `secure_attributes` logic becomes more complex
2. **Mock Telegram::Auth** to test the assertion grant flow
3. **Add token refresh tests** if you implement refresh tokens
4. **Add token revocation tests** if needed
