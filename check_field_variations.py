import json

with open('openapi.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

path = '/employees/greg/business/{business_id}'
put_op = data['paths'].get(path, {}).get('put', {})
if not put_op:
    print("PUT operation not found for path")
    exit()

content = put_op.get('requestBody', {}).get('content', {})
print(f"Supported Content-Types: {list(content.keys())}")

for ct in content:
    schema_ref = content[ct].get('schema', {}).get('$ref')
    if schema_ref:
        schema_name = schema_ref.split('/')[-1]
        schema = data['components']['schemas'].get(schema_name, {})
        print(f"\n--- Fields in {ct} ({schema_name}) ---")
        for prop in schema.get('properties', {}).keys():
            print(f" - {prop}")
    else:
        print(f"No ref for {ct}")
