import json

with open('openapi.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

custom_policies_schema = data['components']['schemas'].get('GregCustomPolicies', 'NOT FOUND')
print(json.dumps(custom_policies_schema, indent=2))
