import json

with open('openapi.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

path = '/employees/greg/business/{business_id}'
put_op = data['paths'][path]['put']
content = put_op['requestBody']['content']
schema_ref = content['application/x-www-form-urlencoded']['schema']['$ref']
schema_name = schema_ref.split('/')[-1]

schema = data['components']['schemas'][schema_name]
props = schema['properties']

print(f"Schema: {schema_name}")
for prop_name, prop_details in props.items():
    print(f"\n--- {prop_name} ---")
    print(json.dumps(prop_details, indent=2))
