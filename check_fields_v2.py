import json

with open('openapi.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

path = '/employees/greg/business/{business_id}'
schema_ref = data['paths'][path]['put']['requestBody']['content']['application/x-www-form-urlencoded']['schema']['$ref']
schema_name = schema_ref.split('/')[-1]
schema = data['components']['schemas'][schema_name]
props = schema['properties']

results = {}
for target in ['custom_policies', 'excluded_phones', 'library', 'blacklist', 'procedures', 'accepted_payment_methods', 'cancellation_documents']:
    if target in props:
        results[target] = props[target]
    else:
        results[target] = "NOT FOUND"

print(json.dumps(results, indent=2))
