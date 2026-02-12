import json

with open('openapi.json', 'r') as f:
    data = json.load(f)

path = '/employees/greg/business/{business_id}'
put_op = data['paths'][path]['put']
content = put_op['requestBody']['content']

with open('put_cts.txt', 'w', encoding='utf-8') as f:
    f.write(f"Content types for PUT: {list(content.keys())}\n")
    for ct in content:
        f.write(f"--- Schema for {ct} ---\n")
        schema_info = content[ct].get('schema', {})
        if '$ref' in schema_info:
            f.write(f"Ref: {schema_info['$ref']}\n")
        else:
            f.write(f"Inline schema: {schema_info.get('type')}\n")






